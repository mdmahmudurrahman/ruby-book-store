# frozen_string_literal: true
class CouponLoadByName < Rectify::Command
  def initialize(name)
    @name = name
  end

  def call
    coupon = Coupon.find_by name: @name

    if coupon.try :available?
      broadcast :success; coupon
    elsif coupon
      broadcast :expired; nil
    elsif @name && !@name.try(:empty?)
      broadcast :invalid; nil
    end
  end
end
