class EscalationController < ApplicationController
  unloadable


  def index
      @escalations = Escalation.find(:all)
  end

end
