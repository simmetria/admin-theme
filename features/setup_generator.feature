Feature: Test admin-theme setup

  Scenario: Setup admin-theme
    Given a new rails app
    And I install 'admin-theme' gem
    When I run 'rails generate admin_theme:setup'
    Then the necessary files should be generated
    And the assets and routes files should be modified
