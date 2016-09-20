# frozen_string_literal: true
module Authentication
  extend ActiveSupport::Concern

  included do
    def authenticate_admin!
      authenticate_user!
    end

    def current_admin_user
      current_user if current_user.try :admin?
    end

    rescue_from CanCan::AccessDenied do
      flash[:error] = I18n.t 'cancan.access_denied'
      redirect_to main_app.error_path
    end
  end
end
