# frozen_string_literal: true
FactoryGirl.define do
  factory :address do
    city { FFaker::Address.city }
    country { FFaker::Address.country_code }
    street { FFaker::Address.street_address }
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    zipcode { Faker::Number.numerify '#####' }
    phone { Faker::Number.numerify '#########' }
  end
end
