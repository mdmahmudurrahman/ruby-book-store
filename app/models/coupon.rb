# frozen_string_literal: true
class Coupon < ApplicationRecord
  ###=> validations

  validates :name, :discount, presence: true
  validates :discount, inclusion: { in: 1..99 }

  ###=> scopes

  scope :available, -> { where available: true }

  ###=> methods

  def discount_multiplier
    discount / 100.0
  end
end
