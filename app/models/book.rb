# frozen_string_literal: true
class Book < ApplicationRecord
  ###=> kaminari configuration
  paginates_per 12

  ###=> book cover image loader
  mount_uploader :cover, BookCoverUploader

  ###=> associations

  has_many :authorisations, dependent: :destroy
  has_many :authors, through: :authorisations

  has_many :categorisations, dependent: :destroy
  has_many :categories, through: :categorisations

  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :restrict_with_error

  ###=> validations

  validates :title, :price, :count, :authors,
            :categories, presence: true

  validates :visible, inclusion: [true, false]

  validates :price, numericality: {
    greater_than_or_equal_to: 0.01
  }

  validates :count, numericality: {
    greater_than_or_equal_to: 0, only_integer: true
  }

  ###=> scopes

  default_scope { order 'created_at DESC' }

  scope :visible, -> { where visible: true }
  scope :hidden, -> { where visible: false }

  scope :bestsellers, -> (count = 5) do
    left_outer_joins(:order_items)
      .select('books.*, count(order_items.quantity) as quantity')
      .group('books.id').reorder('quantity desc, created_at desc')
      .limit count
  end

  ###=> delegates

  delegate :visible, to: :reviews, prefix: true

  ###=> methods

  def label
    title
  end
end
