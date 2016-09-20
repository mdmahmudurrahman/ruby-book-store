# frozen_string_literal: true
class OrderItemDecorator < ApplicationDecorator
  delegate_all

  %i(book order).each do |association|
    decorates_association association
  end

  def formatted_price
    number_to_currency price
  end

  def formatted_total_price
    number_to_currency total
  end
end
