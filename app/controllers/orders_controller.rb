# frozen_string_literal: true
class OrdersController < ApplicationController
  include Orderization

  load_and_authorize_resource :order

  before_action :initialize_user,
                :initialize_order

  decorates_assigned :user,
                     :order,
                     :details

  def index
    @orders = {
      in_queue:    orders_in_queue,
      in_delivery: orders_in_delivery,
      delivered:   orders_delivered
    }
  end

  def show
    @details = @order.details
  end

  private

  def initialize_user
    @user = current_user
  end

  def initialize_order
    @order ||= current_order
  end

  %i(in_queue in_delivery delivered).map { |type| "orders_#{type}" }.each do |method|
    define_method(method) { OrderDecorator.decorate_collection @user.send method }
  end
end
