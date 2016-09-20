# frozen_string_literal: true
feature 'Cart' do
  let(:book) { create :book }

  background do
    caption = I18n.t 'books.order_form.add_to_cart'
    visit book_path id: book.id
    click_button caption
    visit cart_path
  end

  scenario '#add' do
    expect(page).to have_content book.title
  end

  scenario '#update' do
    fill_in 'order[items_attributes][0][quantity]', with: 3
    click_button I18n.t 'carts.show.update'

    %i(item order).each do |element|
      within ".#{element}-total-price" do
        expect(page).to have_content book.price * 3
      end
    end
  end

  scenario '#delete' do
    find('.delete-button').click
    expect(page).not_to have_content book.title

    message = I18n.t 'carts.show.cart_is_empty'
    expect(page).to have_content message
  end

  scenario '#empty cart' do
    click_link I18n.t 'carts.show.empty_cart'
    expect(page).not_to have_content book.title

    message = I18n.t 'carts.show.cart_is_empty'
    expect(page).to have_content message
  end
end
