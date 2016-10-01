# frozen_string_literal: true
class ReviewCreate < Rectify::Command
  def initialize(review, params)
    @review = review
    @params = params
  end

  def call
    @review.assign_attributes @params

    status = if @review.valid? && @review.save
               :success
             else
               :failure
             end

    broadcast status
  end
end
