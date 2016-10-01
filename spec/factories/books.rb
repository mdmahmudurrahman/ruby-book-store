# frozen_string_literal: true
FactoryGirl.define do
  factory :book do
    title { FFaker::CheesyLingo.title }
    price { FFaker.numerify '#5.00' }
    count { Faker::Number.between 3, 10 }

    description_short { FFaker::CheesyLingo.paragraph 50 }
    description_full { FFaker::CheesyLingo.paragraph 90 }

    transient do
      authors_count 2
      categories_count 1
    end

    before(:create) do |book, evaluator|
      book.authors << build_list(:author, evaluator.authors_count)
      book.categories << build_list(:category, evaluator.categories_count)
    end

    factory(:soldout_book) { count 0 }
    factory(:hidden_book) { visible false }

    factory(:book_with_reviews) do
      reviews { build_list :review, 5 }
    end
  end
end
