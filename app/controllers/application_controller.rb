# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers

  include Localization
  include Adminization
  include Authentication

  protect_from_forgery with: :exception

  private

  def default_url_options
    { locale: I18n.locale }
  end
end
