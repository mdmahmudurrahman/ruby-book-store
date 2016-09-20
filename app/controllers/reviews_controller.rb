# frozen_string_literal: true
class ReviewsController < ApplicationController
  load_and_authorize_resource :book

  decorates_assigned :book, :review

  before_action :authenticate_user!,
                :initialize_review

  def new
  end

  def create
    parameters = params.require(:review)
                       .permit(:text, :mark)
                       .merge user: current_user

    ReviewCreate.call @review, parameters do
      on(:success) do
        message = t 'reviews.review_created'
        redirect_to book, notice: message
      end

      on(:failure) { render :new }
    end
  end

  private

  def initialize_review
    @review = @book.reviews.build
  end
end
