# frozen_string_literal: true
class Category < ApplicationRecord
  ###=> associations

  has_many :categorisations

  has_many :books, through: :categorisations,
                   dependent: :restrict_with_error

  has_many :books_visible, -> { merge Book.visible },
           through: :categorisations, source: :book

  ###=> scopes

  scope :with_visible_books, -> do
    includes :categorisations, :books_visible
  end

  ###=> validations

  validates :name, presence: true, uniqueness: true

  ###=> methods

  def label
    name
  end
end
