# frozen_string_literal: true
class OrderDetail < ApplicationRecord
  ###=> associations

  has_one :order, autosave: false

  belongs_to :credit_card
  belongs_to :delivery_method
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  ###=> callbacks

  after_update :update_order, if: :delivery_method_id_changed?

  ###=> form configurations

  accepts_nested_attributes_for :credit_card,
                                :billing_address,
                                :shipping_address

  ###=> methods

  def shipping_price
    delivery_method.try(:price) || 0
  end

  def set_delivery_method
    self.delivery_method ||= DeliveryMethod.default_one
  end

  private

  def update_order
    order.save
  end
end
