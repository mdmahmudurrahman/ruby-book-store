# frozen_string_literal: true
class CategoriesController < ApplicationController
  include CategoriesLoader

  load_and_authorize_resource :category
  decorates_assigned :books, :category

  before_action :initialize_books

  def show
    @books = @books.page params[:page]
  end

  private

  def initialize_books
    @books = @category.books_visible
  end
end
