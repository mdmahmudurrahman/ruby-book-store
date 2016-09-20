# frozen_string_literal: true
FactoryGirl.define do
  factory :review do
    user
    mark { Faker::Number.between 1, 5 }
    text { FFaker::CheesyLingo.paragraph 30 }
  end
end
