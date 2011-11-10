class EscalationsController < ApplicationController
  unloadable

  def index
      @project = Project.find(params[:project_id])
      @escalations = Escalations.find(:all, :conditions => { :project_id => @project.id})

# TODO: Not sure we need this ... 
      @escalations.each do |escalation| 
          escalation.popIssue
      end
  end

end
