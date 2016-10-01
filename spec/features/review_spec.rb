# frozen_string_literal: true
feature Review do
  let(:user) { create :user }
  let(:book) { create :book }

  let(:review) { create :review, book: book }

  background do
    login_as user, scope: :user
    visit book_path id: book.id
  end

  scenario '#create' do
    click_link I18n.t 'books.reviews.here'

    %i(text mark).each do |field|
      value = review.send field
      selector = "review_#{field}"
      fill_in selector, with: value
    end

    click_button I18n.t 'reviews.new.send'
    message = I18n.t 'reviews.review_created'

    expect(page).to have_content message
    expect(page).not_to have_content review.text
  end

  scenario '#moderate' do
    review.update visible: true
    visit book_path id: book.id
    expect(page).to have_content review.text
  end
end
