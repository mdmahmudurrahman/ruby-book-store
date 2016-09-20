# frozen_string_literal: true
class OrderItemsController < ApplicationController
  include Orderization

  load_and_authorize_resource :book, only: :create
  before_action :initialize_order_item, only: :destroy

  def create
    parameters = params.require(:order_item)
                       .permit(:quantity)
                       .merge book: @book

    OrderItemCreate.call current_order, parameters do
      on(:success) do
        save_order_cookie unless current_user
        flash[:notice] = t 'book_added_to_cart'
      end
    end

    redirect_to @book
  end

  def destroy
    @order_item.destroy
    redirect_to cart_path
  end

  private

  def initialize_order_item
    id = params.dig :id
    items = current_order.items
    @order_item = items.find id
  end
end
