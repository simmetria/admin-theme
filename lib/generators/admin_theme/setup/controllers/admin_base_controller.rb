class Admin::BaseController < ApplicationController
  protect_from_forgery
  layout 'admin'

  before_filter :show_errors

  private

  def show_errors
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      if html_tag =~ /<label/
        %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
      else
        html_tag
      end
    end
  end
end
