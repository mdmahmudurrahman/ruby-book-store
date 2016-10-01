# frozen_string_literal: true
class ReviewDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def create_date
    I18n.l created_at, format: :short
  end
end
