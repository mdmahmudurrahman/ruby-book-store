# frozen_string_literal: true
class DeliveryMethod < ApplicationRecord
  ###=> callbacks

  before_save(if: '!active') { self.default = false }
  before_save(if: 'default and default_changed?') { reset_default_method }
  after_save(if: '!active and active_changed?') { update_default_method }

  ###=> validations

  validates :name, :price, presence: true
  validates :price, inclusion: { in: 1..100 }

  ###=> scopes

  scope :cheap, -> { order :price }

  scope :active, -> { where active: true }
  scope :default, -> { where default: true }

  ###=> methods

  def self.default_one
    default.first || update_default_method; default.first
  end

  private

  def update_default_method
    method = DeliveryMethod.active.cheap.first
    method = DeliveryMethod.cheap.first unless method
    method.update active: true, default: true
  end

  def reset_default_method
    methods = DeliveryMethod.default
    methods.update default: false
  end
end
