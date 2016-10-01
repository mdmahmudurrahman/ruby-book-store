# frozen_string_literal: true
class OrderDecorator < ApplicationDecorator
  delegate_all

  %i(items details).each do |association|
    decorates_association association
  end

  def formatted_id
    id.to_s.rjust 8, '0'
  end

  def formatted_name
    "#{t 'orders.show.order_title'} ##{formatted_id}"
  end

  def formatted_completed_at
    formatted_order_date completed_at || updated_at
  end

  def formatted_order_date(date)
    I18n.localize date, format: :short
  end

  def coupon_price
    order.items_price * order.coupon.discount_multiplier
  end

  %i(items total shipping coupon).each do |type|
    define_method "formatted_#{type}_price" do
      number_to_currency send "#{type}_price"
    end
  end
end
