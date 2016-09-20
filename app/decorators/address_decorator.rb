# frozen_string_literal: true
class AddressDecorator < ApplicationDecorator
  delegate_all

  def fullname
    "#{firstname} #{lastname}"
  end

  def full_country
    ISO3166::Country[country]
  end
end
