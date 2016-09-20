# frozen_string_literal: true
class DeliveryMethodDecorator < ApplicationDecorator
  delegate_all

  def formatted_name
    "#{name} + #{formatted_price}"
  end

  def formatted_price
    number_to_currency price
  end
end
