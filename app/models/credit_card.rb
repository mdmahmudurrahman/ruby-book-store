# frozen_string_literal: true
class CreditCard < ApplicationRecord
  ###=> validations

  validates :firstname, :lastname, :month, :year,
            :code, :number, presence: true

  validates :number, format: { with: /\A[0-9]{16}\z/ }
  validates :code, :year, format: { with: /\A[0-9]{4}\z/ }
  validates :month, format: { with: /\A(0[1-9]|1[0-2])\z/ }
end
