# frozen_string_literal: true
class OrderItemCreate < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    item = OrderItem.new @params

    success = if item.valid?
                @order.add_item item
                @order.save
              end

    broadcast success ? :success : :failure
  end
end
