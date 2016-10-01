# frozen_string_literal: true
class BookDecorator < ApplicationDecorator
  delegate_all

  %i(reviews authors categories).each do |association|
    decorates_association association
  end

  def link
    link_to title, path
  end

  def new_review_path
    new_book_review_path self
  end

  def formatted_price
    number_to_currency price
  end

  def comma_separated_authors
    authors.map(&:link).to_sentence.html_safe
  end

  %i(short full).map { |type| "description_#{type}" }.each do |method|
    define_method(method) { simple_format model.send method }
  end
end
