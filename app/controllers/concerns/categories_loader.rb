# frozen_string_literal: true
module CategoriesLoader
  extend ActiveSupport::Concern

  included do
    decorates_assigned :categories

    before_action :initialize_categories

    def initialize_categories
      @categories = Category.with_visible_books.order :name
    end
  end
end
