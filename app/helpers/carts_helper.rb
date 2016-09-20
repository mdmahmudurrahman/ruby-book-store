# frozen_string_literal: true
module CartsHelper
  def quantity_field_options(book)
    { min: 1, max: book.count, class: 'form-control text-center' }
  end

  def coupon_field_options
    { placeholder: I18n.t('carts.show.coupon_code'),
      class: 'form-control coupon-field' }
  end

  def delete_item_link_options(item)
    path = order_item_path item.order, item
    delete_link_options.merge href: path
  end

  def empty_cart_link_options
    delete_link_options.merge href: empty_cart_path
  end

  def delete_link_options
    { 'data-method': 'delete', 'rel': 'nofollow' }
  end
end
