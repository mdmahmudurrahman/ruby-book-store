# frozen_string_literal: true
class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    email
  end
end
