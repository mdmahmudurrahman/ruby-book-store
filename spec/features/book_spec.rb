# frozen_string_literal: true
feature Book do
  let(:book) { create :book }

  let(:soldout_book) do
    create :soldout_book
  end

  context '#available' do
    background { visit book_path id: book.id }

    scenario '#description popup', js: true do
      expect(page).to have_css 'a.readmore'
      click_on I18n.t 'books.show.read_more_link_text'
      expect(page).to have_content book.description_full
    end

    scenario '#add to cart' do
      expect(page).to have_content book.price
      expect(page).to have_css 'input[type=submit]'
      expect(page).to have_css '#order_item_quantity'

      click_on I18n.t 'books.order_form.add_to_cart'

      message = I18n.t 'book_added_to_cart'
      expect(page).to have_content message
    end
  end

  context '#soldout' do
    background { visit book_path id: soldout_book.id }

    scenario '#add to cart' do
      expect(page).to have_content soldout_book.price
      expect(page).not_to have_css 'input[type=submit]'
      expect(page).to have_content I18n.t 'books.order_form.sold_out'
    end
  end
end
