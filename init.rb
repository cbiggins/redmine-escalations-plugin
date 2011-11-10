require 'redmine'

Redmine::Plugin.register :redmine_escalations do
  name 'Redmine Escalations plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :escalations, { :escalations => [:index, :view] }, :public => true
  menu :project_menu, :escalations, { :controller => 'escalations', :action => 'index' }, :caption => 'Escalations', :after => :issues, :param => :project_id

end