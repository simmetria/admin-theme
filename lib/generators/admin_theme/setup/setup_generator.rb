module AdminTheme
  class SetupGenerator < Rails::Generators::Base
    desc "Creates the admin layout, assets, admin base and dashboard controllers."
    source_root File.expand_path('../templates', __FILE__)

    class_option :app_name, :type => :string, :default => 'Admin', :desc => 'Specify the application name'

    def create_views
      template "layout_admin.html.erb",   "app/views/layouts/admin.html.erb"
      template "view_sidebar.html.erb",   "app/views/admin/shared/_sidebar.html.erb"
      template "view_dashboard.html.erb", "app/views/admin/dashboard/show.html.erb"
    end

    def create_controllers
      copy_file "../controllers/admin_base_controller.rb",      "app/controllers/admin/base_controller.rb"
      copy_file "../controllers/admin_dashboard_controller.rb", "app/controllers/admin/dashboard_controller.rb"

      inject_into_file "config/routes.rb",
"  namespace :admin do
    root :to => 'dashboard#show', :as => 'dashboard'
  end\n\n", :after => "::Application.routes.draw do\n"
    end

    def create_stylesheet
      create_file "app/assets/stylesheets/admin.css",
"/*
 *= require web-app-theme
 *= require web-app-theme/default
 *= require_self
*/\n"
    end

    def create_javascript
      create_file "app/assets/javascripts/admin.js", "//= require jquery\n//= require jquery_ujs\n"
    end
  end
end
