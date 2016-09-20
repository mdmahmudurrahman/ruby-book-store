# frozen_string_literal: true
class Order < ApplicationRecord
  include AASM

  ###=> associations

  belongs_to :user
  belongs_to :coupon

  has_many :items, dependent: :destroy, class_name: OrderItem
  belongs_to :details, dependent: :destroy, class_name: OrderDetail

  ###=> delegates

  delegate :shipping_price, :delivery_method, to: :details

  ###=> callbacks

  after_initialize :build_details

  before_save :set_completed_at_time, if: :state_changed?
  before_save :calculate_item_price, :calculate_total_price

  ###=> form configurations

  accepts_nested_attributes_for :items

  ###=> aasm

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event(:checkout) { transitions from: :in_progress, to: :in_queue }
    event(:confirm) { transitions from: :in_queue, to: :in_delivery }
    event(:deliver) { transitions from: :in_delivery, to: :delivered }
    event(:cancel) { transitions from: :in_queue, to: :canceled }
  end

  ###=> validations

  validates :state, presence: true

  ###=> methods

  def add_item(item)
    existed = items.detect { |e| e.book == item.book }
    existed ? existed.merge(item) : items << bind_item(item)
  end

  private

  def set_completed_at_time
    self.completed_at = Time.zone.now if %w(delivered canceled).include? state
  end

  def build_details
    super unless details
  end

  def bind_item(item)
    item.order = self; item
  end

  def discount_multiplier
    coupon.try(:discount_multiplier) || 0
  end

  def calculate_item_price
    self.items_price = items.inject(0) { |total, item| total + item.total }
  end

  def calculate_total_price
    self.total_price = items_price * (1.0 - discount_multiplier) + shipping_price
  end
end
