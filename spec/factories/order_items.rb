# frozen_string_literal: true
FactoryGirl.define do
  factory :order_item do
    book
    order
    quantity { Faker::Number.between 2, 10 }
  end
end
