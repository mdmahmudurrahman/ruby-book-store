# frozen_string_literal: true
FactoryGirl.define do
  factory :order do
    user
    details

    Order.aasm.states.map(&:name).each do |state|
      factory("order_#{state}") { state state }
    end

    factory :order_with_items do
      transient do
        items_count 3
      end

      before(:create) do |order, evaluator|
        build_list(:order_item, evaluator.items_count, order: order).each do |item|
          order.add_item item
        end
      end
    end

    factory :order_with_coupon do
      coupon
    end
  end
end
