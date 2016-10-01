# frozen_string_literal: true
class Address < ApplicationRecord
  ###=> validations

  validates :street, :firstname, :lastname, :zipcode,
            :city, :country, :phone, presence: true
end
