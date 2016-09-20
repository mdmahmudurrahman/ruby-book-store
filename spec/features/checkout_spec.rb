# frozen_string_literal: true
feature 'Checkout' do
  let(:user) { create :user_with_order }

  context '#sequence' do
    background do
      login_as user, scope: :user; visit cart_path
      click_link I18n.t 'carts.show.checkout'
    end

    scenario '#steps' do
      %w(address delivery payment confirm).each do |step|
        expect(page).to have_css "div[step=#{step}]"
        find('input[name=commit]').click
      end

      identifier = user.orders_in_queue.last.id
      expect(page).to have_content identifier
    end
  end

  context '#address step' do
    let(:address) { build :address }
    let(:details) { user.order.details }

    background { login_as user, scope: :user }

    scenario '#create billing and shipping' do
      details.update shipping_address: nil,
                     billing_address: nil

      fill_billing_form_and_submit
      expect(Address.count).to eq 4
    end

    scenario '#create shipping according to billing' do
      details.update shipping_address: nil
      fill_billing_form_and_submit
      expect(Address.count).to eq 3
    end

    scenario '#update shipping according to billing' do
      fill_billing_form_and_submit
      expect(Address.count).to eq 2
    end

    def fill_billing_form_and_submit
      visit cart_path; click_link I18n.t 'carts.show.checkout'
      check I18n.t 'checkout.form_address.use_data_from_billing_address'

      %i(firstname lastname street city zipcode phone).each do |field|
        fill_in "billing_address_attributes_#{field}", with: address.send(field)
      end

      text = I18n.t 'checkout.form_address.billing_address'
      click_on I18n.t 'checkout.save_and_continue'
      expect(page).not_to have_content text

      details.reload

      %i(firstname lastname street city zipcode phone).each do |field|
        expect(details.shipping_address.send(field)).to eq address.send field
      end
    end
  end
end
