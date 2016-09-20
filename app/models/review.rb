# frozen_string_literal: true
class Review < ApplicationRecord
  ###=> associations

  belongs_to :book
  belongs_to :user

  ###=> callbacks

  before_update { |review| review.new = false }

  ###=> validations

  validates :text, :mark, :book, :user, presence: true

  validates :mark, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true
  }

  ###=> scopes

  scope :visible, -> { where visible: true }
end
