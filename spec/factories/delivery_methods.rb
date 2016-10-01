# frozen_string_literal: true
FactoryGirl.define do
  factory :delivery_method do
    sequence :name do |value|
      "Delivery Method #{value}"
    end

    price { Faker::Number.between 1, 20 }
  end
end
