# frozen_string_literal: true
FactoryGirl.define do
  factory :details, class: OrderDetail do
    credit_card
    delivery_method
    billing_address { create :address }
    shipping_address { create :address }
  end
end
