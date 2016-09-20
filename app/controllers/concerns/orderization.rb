# frozen_string_literal: true
module Orderization
  extend ActiveSupport::Concern

  included do
    def current_order
      loaded_order = order_from_user || order_from_cookie
      @current_order ||= loaded_order || create_new_order
    end

    private

    def order_from_user
      current_user.try :order
    end

    def order_from_cookie
      id = cookies.encrypted[:order]
      Order.in_progress.find_by id: id
    end

    def create_new_order
      Order.new user: current_user
    end

    def save_order_cookie
      expires = 30.days.from_now
      identifier = current_order.id

      cookies.encrypted[:order] = {
        value: identifier,
        expires: expires
      }
    end

    def delete_order_cookie
      cookies.delete :order
    end
  end
end
