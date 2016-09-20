# frozen_string_literal: true
class OrderItem < ApplicationRecord
  ###=> associations

  belongs_to :book

  belongs_to :order

  delegate :image, :title, :formatted_price,
           :description_short, to: :book

  ###=> validations

  validates :quantity, numericality: { only_integer: true }
  validates :book, :price, :total, :quantity, presence: true
  validates :price, :total, :quantity, numericality: { greater_than: 0 }

  ###=> callbacks

  after_initialize :prepare
  before_validation :prepare

  after_save { order.save }
  after_destroy { order.save }

  ###=> methods

  def merge(item)
    self.price = item.price
    self.quantity += item.quantity
  end

  private

  def prepare
    if book
      self.price = book.price
      self.total = calculate_total
    end
  end

  def calculate_total
    quantity * price
  end
end
