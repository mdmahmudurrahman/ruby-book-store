# frozen_string_literal: true
class CategoryDecorator < ApplicationDecorator
  delegate_all

  %i(books visible_books).each do |association|
    decorates_association association
  end

  def link(options = {})
    link_to name, path, options
  end
end
