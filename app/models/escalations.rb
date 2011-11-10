class Escalations < ActiveRecord::Base

  belongs_to :issue

  attr_accessor :issue

  def view(project_id)
      puts 'here'
  end

  def popIssue
      self.issue = Issue.find(:all, :conditions => { :id => self.issue_id})
  end
  
  def getIssue
     Issue.find(:all, :conditions => { :id => self.issue_id}) 
  end

end
