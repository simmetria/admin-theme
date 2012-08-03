Feature: Test admin-theme resource generation

  Scenario: Generate an admin-theme resource
    Given a new rails app
    And I install 'admin-theme' gem
    And I run 'rails generate admin_theme:setup'
    When I run 'rails generate admin_theme:resource posts'
    Then the posts resource in admin panel should be generated
    And the routes file should be modified
