# frozen_string_literal: true
FactoryGirl.define do
  factory :credit_card do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }

    code { Faker::Number.numerify '####' }
    number { Faker::Number.numerify '#' * 16 }

    year { Faker::Number.between 2020, 2030 }
    month { Faker::Number.between(1, 12).to_s.rjust 2, '0' }
  end
end
