# frozen_string_literal: true
class Categorisation < ApplicationRecord
  ###=> associations

  belongs_to :book
  belongs_to :category

  ###=> validations

  validates :book, :category, presence: true
end
