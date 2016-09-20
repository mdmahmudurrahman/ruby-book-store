# frozen_string_literal: true
class BooksController < ApplicationController
  load_and_authorize_resource :book
  decorates_assigned :book, :reviews

  def show
    @reviews = @book.reviews_visible
  end
end
