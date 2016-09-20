# frozen_string_literal: true
FactoryGirl.define do
  factory :category do
    sequence :name do |value|
      "#{FFaker::CheesyLingo.title} #{value}"
    end
  end
end
