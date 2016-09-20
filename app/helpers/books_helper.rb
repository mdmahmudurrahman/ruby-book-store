# frozen_string_literal: true
module BooksHelper
  def book_cover_options
    { class: 'thumbnail center-block' }
  end

  def add_review_button_options
    { class: 'btn btn-primary add-new-review-button' }
  end

  def add_to_cart_form_options(book)
    { url: book_order_path(book), html: { class: 'pull-right form-horizontal' } }
  end

  def quantity_field_options(book)
    input_html = { value: 1, min: 1, max: book.count }
    wrapper_html = { class: 'pull-left', style: 'margin: 0' }
    { as: :integer, label: false, input_html: input_html, wrapper_html: wrapper_html }
  end

  def add_to_cart_button_options
    { class: 'btn btn-success' }
  end

  def mark_options
    { 'data-show-caption': 'false', 'data-size': 'sm', 'data-step': '1',
      'data-show-clear': 'false', 'class': 'rating rating-loading' }
  end

  def mark_read_only_options(value)
    mark_options.merge 'readonly': true, 'data-size': 'xs', 'value': value
  end
end
