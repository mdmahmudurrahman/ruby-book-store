# frozen_string_literal: true
module OrdersHelper
  def cart_link
    text = t 'orders.order_items.go_to_cart_link'
    link_to text, cart_path, cart_link_options
  end

  def shop_link
    text = t 'orders.show.continue_shopping_link'
    link_to text, store_path, shop_link_options
  end

  def cart_link_options
    { class: 'btn btn-default' }
  end

  def shop_link_options
    { class: 'btn btn-info' }
  end
end
