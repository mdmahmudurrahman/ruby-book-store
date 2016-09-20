# frozen_string_literal: true
feature Coupon do
  let(:book) { create :book }

  background do
    caption = I18n.t 'books.order_form.add_to_cart'
    visit book_path id: book.id
    click_button caption
    visit cart_path
  end

  scenario '#available' do
    fill_with_coupon_and_submit create :coupon

    within('.subtotal-price') { expect(page).to have_content book.price }
    within('.coupon-price') { expect(page).to have_content book.price * 0.25 }
    within('.order-total-price') { expect(page).to have_content book.price * 0.75 }

    expect(page).not_to have_css '.coupon-field'
    expect(page).to have_content I18n.t 'coupon_applied'
  end

  scenario '#unavailable' do
    coupon = create :unavailable_coupon
    fill_with_coupon_and_submit coupon

    %i(item order).each do |e|
      within ".#{e}-total-price" do
        expect(page).to have_content book.price
      end
    end

    expect(page).to have_content I18n.t 'coupon_expired'
  end

  scenario '#invalid' do
    fill_with_coupon_and_submit build :coupon
    expect(page).to have_content I18n.t 'coupon_invalid'
  end

  def fill_with_coupon_and_submit(coupon)
    within '.edit_order' do
      fill_in 'order[coupon]', with: coupon.name
      click_button I18n.t 'carts.show.update'
    end
  end
end
