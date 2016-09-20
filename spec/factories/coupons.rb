# frozen_string_literal: true
FactoryGirl.define do
  factory :coupon do
    sequence :name do |value|
      "Coupon ##{value}"
    end

    discount 25
    available true

    factory :unavailable_coupon do
      available false
    end
  end
end
