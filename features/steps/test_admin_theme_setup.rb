class TestAdminThemeSetup < Spinach::FeatureSteps
  include Helpers

  Given 'a new rails app' do
    `rails new #{app_name}`
  end

  And 'I install \'admin-theme\' gem' do
    in_app_dir { `echo "'admin-theme', github: 'simmetria/admin-theme'" >> Gemfile && bundle` }
  end

  When 'I run \'rails generate admin_theme:setup\'' do
    in_app_dir { @output = `rails g admin_theme:setup` }
  end

  Then 'the necessary files should be generated' do
    setup_files.each { |f| @output.must_include f }
    @output.scan('create').size.must_equal 7
    @output.scan('insert').size.must_equal 1
  end

  And 'the assets and routes files should be modified' do
    routes = read_file('config/routes.rb')
    routes.must_include "namespace :admin do"
    routes.must_include "root :to => 'dashboard#show', :as => 'dashboard'"

    stylesheet = read_file('app/assets/stylesheets/admin.css')
    stylesheet.must_include "*= require web-app-theme"
    stylesheet.must_include "*= require web-app-theme/default"
    stylesheet.must_include "*= require_self"

    javascript = read_file('app/assets/javascripts/admin.js')
    javascript.must_include "//= require jquery"
    javascript.must_include "//= require jquery_ujs"
  end
end
