# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    password { FFaker::Internet.password }

    sequence :email do |value|
      "account-#{value}@example.com"
    end

    factory :admin do
      admin true
    end

    factory :user_with_order do
      before(:create) do |user|
        order = create :order_with_items
        user.orders << order
      end
    end
  end
end
