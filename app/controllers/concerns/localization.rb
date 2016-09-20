# frozen_string_literal: true
module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
    before_action :localize_request

    def set_locale
      locale = extract_locale_from_params
      locale = extract_locale_from_headers unless locale
      locale = I18n.default_locale unless %w(en).include? locale

      I18n.locale = locale
    end

    def extract_locale_from_params
      params[:locale]
    end

    def extract_locale_from_headers
      value = request.env['HTTP_ACCEPT_LANGUAGE']
      value.scan(/^[a-z]{2}/).first if value
    end

    def localize_request
      unless params[:locale] || can_localize_request?
        redirect_to "/#{I18n.locale}#{request.path}"
      end
    end

    def can_localize_request?
      request.path.start_with? '/admin', '/users/auth/facebook'
    end
  end
end
