# frozen_string_literal: true
class OrderItemsController < ApplicationController
  include Orderization

  load_and_authorize_resource :book, only: :create
  before_action :initialize_parameters, only: :create
  before_action :initialize_order_item, only: :destroy

  def create
    OrderItemCreate.call current_order, @params do
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
    @order_item = current_order.items.find params[:id]
  end

  def initialize_parameters
    @params = params.require(:order_item).permit(:quantity).merge book: @book
  end
end
