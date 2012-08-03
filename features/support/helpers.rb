module Helpers
  def app_name
    @app_name = "tmp/test_app#{rand(10..100)}"
  end

  def in_app_dir(&block)
    Dir.chdir(@app_name, &block)
  end

  def read_file(file)
    in_app_dir { File.read(file) }
  end

  def setup_files
    [
      "app/views/layouts/admin.html.erb",
      "app/views/admin/shared/_sidebar.html.erb",
      "app/views/admin/dashboard/show.html.erb",
      "app/controllers/admin/base_controller.rb",
      "app/controllers/admin/dashboard_controller.rb",
      "config/routes.rb",
      "app/assets/stylesheets/admin.css",
      "app/assets/javascripts/admin.js"
    ]
  end

  def resource_files
    [
      "app/controllers/admin/posts_controller.rb",
      "config/routes.rb",
      "app/views/admin/posts/_form.html.erb",
      "app/views/admin/posts/edit.html.erb",
      "app/views/admin/posts/index.html.erb",
      "app/views/admin/posts/new.html.erb",
      "app/views/admin/posts/show.html.erb",
      "app/views/layouts/admin.html.erb"
    ]
  end
end
