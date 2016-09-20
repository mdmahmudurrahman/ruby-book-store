# frozen_string_literal: true
class StoreController < ApplicationController
  include CategoriesLoader

  decorates_assigned :books

  before_action :initialize_books

  def index
    @books = @books.bestsellers.includes :authors
  end

  def store
    @books = @books.page params[:page]
  end

  def error
    redirect_to root_path unless flash[:error]
  end

  private

  def initialize_books
    @books = Book.visible
  end
end
