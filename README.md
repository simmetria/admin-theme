# Admin Theme [![build status](https://secure.travis-ci.org/simmetria/admin-theme.png)](https://secure.travis-ci.org/simmetria/admin-theme)

Admin theme is a fork of [Web App Theme](https://github.com/pilu/web-app-theme) generator. See [demo](http://pilu.github.com/web-app-theme).  
It aims the same goal as a main branch: to generate admin panels quickly.

Changes from main branch:

* Rails 3.1+ compatibility
* Asset pipeline integration
* Auto generation of resources
* Improved I18n support
* Only default theme included
* Kaminari for pagination (optional)

## Installation

Add to your Gemfile:

```ruby
gem 'admin-theme'
```

If you want to paginate records in admin panel also add:

```ruby
gem 'kaminari'
gem 'kaminari-admin-theme'
```

Run `bundle install`

## Usage

1. First time you need to setup admin-theme:

  ```sh
  rails generate admin_theme:setup
  ```

  This will generate some controllers, views for admin panel and prepare assets:

  ```sh
  create  app/views/layouts/admin.html.erb
  create  app/views/admin/shared/_sidebar.html.erb
  create  app/views/admin/dashboard/show.html.erb
  create  app/controllers/admin/base_controller.rb
  create  app/controllers/admin/dashboard_controller.rb
  insert  config/routes.rb
  create  app/assets/stylesheets/admin.css
  create  app/assets/javascripts/admin.js
  ```

  You can pass `app_name` option to specify the application name:

  ```sh
  rails generate admin_theme:setup --app_name="Custom name"
  ```

  After you will be able to access admin panel at `localhost:3000/admin`.

2. Move application stylesheets to `another_dir` and change `application.css` to not load admin-theme stylesheets:

  ```patch
  --*= require_tree .
  ++*= require_tree ./another_dir
  ```

3. You can now use admin-theme resource generator to generate necessary resources in admin panel:

  ```sh
  rails generate admin_theme:resource posts # assuming you have a model named Post
  ```

  If you want to enable pagination:

  ```sh
  rails generate admin_theme:resource posts --pagination
  ```

  If you want to generate resource with different name you can explicitly specify the model name in the second parameter:

  ```sh
  rails generate admin_theme:resource items post # assuming you have a model named Post
  ```

## i18n

See [`config/locales`](https://github.com/simmetria/admin-theme/tree/master/config/locales) for available translations.  
You can add one by yourself in `config/locales`:

```yaml
time:
  formats:
    admin-theme: "%d %b %Y [%H:%M]"

admin-theme:
  save: Save
  cancel: Cancel
  list: List
  edit: Edit
  new: New
  show: Show
  delete: Delete
  confirm: Are you sure?
  created_at: Created at
  all: All
  or: or
```

## Credits

* Web App Theme: [Andrea Franz](http://gravityblast.com)
* Icons: [FAMFAMFAM Silk icons](http://www.famfamfam.com/lab/icons/silk)
* Buttons: Particletree - Rediscovering the Button Element

