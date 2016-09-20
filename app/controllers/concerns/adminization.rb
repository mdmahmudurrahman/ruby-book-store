module Adminization
  extend ActiveSupport::Concern

  included do

    before_action do
      next unless request_path_valid?
      next unless request_method_valid?
      next unless current_admin_user
      redirect_to admin_panel_path
    end

    def request_path_valid?
      not request.path.start_with? '/admin'
    end

    def request_method_valid?
      request.method == 'GET'
    end
  end
end
