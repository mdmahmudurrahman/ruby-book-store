# frozen_string_literal: true
class CreditCardDecorator < ApplicationDecorator
  delegate_all

  def formatted_number
    "•••• •••• •••• #{last_four_digits}"
  end

  def formatted_date
    "#{month} / #{year}"
  end

  private

  def last_four_digits
    number[-4..-1]
  end
end
