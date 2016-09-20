# frozen_string_literal: true
module ReviewsHelper
  def review_form_options(book)
    { url: book_review_path(book) }
  end

  def text_field_options
    { as: :text, label: false, input_html: { rows: 7, placeholder: true } }
  end

  def mark_field_options
    input_html = { 'data-show-caption': 'false', 'data-size': 'sm', 'data-step': '1',
                   'data-show-clear': 'false', 'class': 'rating rating-loading', value: 1 }

    { label: false, input_html: input_html, wrapper_html: { class: 'pull-left' } }
  end

  def send_button_options
    { class: 'btn btn-default pull-right' }
  end

  def cancel_review_button
    text = t 'reviews.new.cancel'
    clazz = 'btn btn-danger pull-right'
    link_to text, book.path, class: clazz
  end
end
