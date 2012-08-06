require 'rails/generators/generated_attribute'

module AdminTheme
  class ResourceGenerator < Rails::Generators::Base
    desc "Creates the resource in admin panel."
    source_root File.expand_path('../templates', __FILE__)

    argument :resource,   :type => :string
    argument :model_name, :type => :string, :required => false

    class_option :engine,     :type => :string,   :default => 'erb', :desc => 'Specify the template engine'
    class_option :pagination, :type => :boolean,  :default => false, :desc => 'Specify if you use kaminari to paginate'

    def initialize(args, *options)
      super(args, *options)
      initialize_views_variables
    end

    def generate_controller
      template "../controllers/admin_resource_controller.erb", "app/controllers/admin/#{plural_resource_name}_controller.rb"
      inject_into_file "config/routes.rb", "    resources :#{plural_resource_name}\n", :after => "namespace :admin do\n"
    end

    def generate_views
      template "#{options.engine}/view_form.html.#{options.engine}",   "app/views/admin/#{plural_resource_name}/_form.html.#{options.engine}"
      template "#{options.engine}/view_edit.html.#{options.engine}",   "app/views/admin/#{plural_resource_name}/edit.html.#{options.engine}"
      template "#{options.engine}/view_index.html.#{options.engine}",  "app/views/admin/#{plural_resource_name}/index.html.#{options.engine}"
      template "#{options.engine}/view_new.html.#{options.engine}",    "app/views/admin/#{plural_resource_name}/new.html.#{options.engine}"
      template "#{options.engine}/view_show.html.#{options.engine}",   "app/views/admin/#{plural_resource_name}/show.html.#{options.engine}"

      # Add link to resource in admin layout
      gsub_file("app/views/layouts/admin.html.erb", /\<div\s+id=\"main-navigation\">.*\<\/ul\>/mi) do |match|
        match.gsub!(/\<\/ul\>/, "")
        %|#{match}  <li class="<%= controller_name == '#{plural_resource_name}' ? 'active' : '' %>">
          <%= link_to "#{plural_model_name}", #{controller_routing_path}_path %>
        </li>
      </ul>|
      end
    end

    private

    def initialize_views_variables
      @base_name, @controller_class_path, @controller_file_path,
      @controller_class_nesting, @controller_class_nesting_depth = extract_modules("admin/#{resource}")

      @controller_routing_path = @controller_file_path.gsub(/\//, '_')
      @model_name = @base_name.singularize unless @model_name
      @model_name = @model_name.camelize
    end

    def controller_routing_path
      @controller_routing_path
    end

    def singular_controller_routing_path
      @controller_routing_path.singularize
    end

    def model_name
      @model_name
    end

    def plural_model_name
      @model_name.pluralize
    end

    def resource_name
      @model_name.underscore
    end

    def plural_resource_name
      resource_name.pluralize
    end

    def model_scope
      if options.pagination
        'page(params[:page]).per(20)'
      else
        'all'
      end
    end

    def extract_modules(name)
      modules   = name.include?('/') ? name.split('/') : name.split('::')
      name      = modules.pop
      path      = modules.map { |m| m.underscore }
      file_path = (path + [name.underscore]).join('/')
      nesting   = modules.map { |m| m.camelize }.join('::')

      [name, path, file_path, nesting, modules.size]
    end
  end
end
