class TestAdminThemeResourceGeneration < Spinach::FeatureSteps
  include Helpers

  Given 'a new rails app' do
    `rails new #{app_name}`
  end

  And 'I install \'admin-theme\' gem' do
    in_app_dir { `echo "'admin-theme', github: 'simmetria/admin-theme'" >> Gemfile && bundle` }
  end

  And 'I run \'rails generate admin_theme:setup\'' do
    in_app_dir { `rails g admin_theme:setup` }
  end

  When 'I run \'rails generate admin_theme:resource posts\'' do
    in_app_dir { @output = `rails g admin_theme:resource posts` }
  end

  Then 'the posts resource in admin panel should be generated' do
    resource_files.each { |f| @output.must_include f }
    @output.scan('create').size.must_equal 6
    @output.scan('insert').size.must_equal 1
    @output.scan('gsub').size.must_equal 1
  end

  And 'the routes file should be modified' do
    routes = read_file('config/routes.rb')
    routes.must_include "resources :posts"
  end
end
