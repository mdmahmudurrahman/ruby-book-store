# frozen_string_literal: true
class AuthorsController < ApplicationController
  load_and_authorize_resource :author
  decorates_assigned :author, :books

  before_action :initialize_books

  def show
    @books = @books.page params[:page]
  end

  private

  def initialize_books
    @books = @author.books_visible
  end
end
