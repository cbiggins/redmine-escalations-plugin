require 'action_mailer'

# Allows us to use a .erb template
ActionMailer::Base.template_root='vendor/plugins/redmine_escalations/app/views/'

class Notifier < ActionMailer::Base
   def escalation_notification(recipient, issue)
     recipients recipient.mail
     from       "redmine@previousnext.com.au"
     subject    "Issue Escalation: " + issue.to_s
     body       :issue => issue
   end
end

namespace :redmine do
   task :check_escalations_all => :environment do
       
       # Support Tracker ... 
       @tracker = Tracker.find(:first, :conditions => { :name => 'Support' })
       
       #  Now ... 
       now = Time.now
       # 2 Hours Ago ...
       t = Time.now - 7200

       # Lets get only the issues that were created over 2 hours ago and have not been updated. And are in the Support Tracker
       hash_conditions = {:tracker_id => @tracker}
       conditions = Issue.merge_conditions(hash_conditions) + ' AND created_on < "'+ now.to_s(:db) +'" AND created_on = updated_on'
       @issues = Issue.find(:all, :conditions => conditions)

       # Now, lets get the users in the Support role
       @role = Role.find(:first, :conditions => {:name => 'Project Manager'} )

       # We'll populate a user array so we can loop over them for the notifications
       users = []
       @role.members.each do |member|
           user = User.find(:first, :conditions => {:id => member.user_id})
           if !users.include?(user) 
               users << user
           end
       end
       
       #  We'll loop over the issues and email all role members about each one.
       @issues.each do |issue|

           sent_to = []
           users.each do |user|
               if user != nil && !sent_to.include?(user.mail)
                   mail = Notifier.create_escalation_notification(user, issue) 
                   puts YAML.dump(mail)
                   Notifier.deliver(mail)
                   sent_to << user.mail
               end
           end

           # Update the updated_on time so the same issue does not hook the next time this script runs.
           issue.updated_on = now
           issue.save
           Escalations.create(:project_id => issue.project_id, :issue_id => issue.id, :date_escalated => now.to_s(:db))
       end
   end
end