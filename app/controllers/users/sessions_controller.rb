# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  include Orderization

  def create
    super; bind_order_to_user
  end

  def destroy
    super; delete_order_cookie
  end

  private

  def bind_order_to_user
    user.update order: order
  end

  def user
    current_user
  end

  def order
    current_order
  end
end
