# frozen_string_literal: true
class OrderDetailDecorator < ApplicationDecorator
  delegate_all

  decorates_association :credit_card
  decorates_association :delivery_method
  decorates_association :billing_address
  decorates_association :shipping_address
end
