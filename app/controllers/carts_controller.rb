# frozen_string_literal: true
class CartsController < ApplicationController
  include Orderization

  decorates_assigned :order

  before_action :initialize_order

  def show
  end

  def empty
    @order.destroy
    redirect_to :cart
  end

  def update
    parameters = params.require(:order).permit \
      items_attributes: %i(id quantity)

    coupon = CouponLoadByName.call params.dig :order, :coupon do
      on(:invalid) { flash[:notice] = t :coupon_invalid }
      on(:expired) { flash[:notice] = t :coupon_expired }
    end

    parameters[:coupon] = coupon if coupon

    result = @order.update(parameters) && coupon
    flash[:notice] = t :coupon_applied if result

    redirect_to :cart
  end

  private

  def initialize_order
    @order = current_order
  end
end
