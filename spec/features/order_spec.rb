# frozen_string_literal: true
feature Order do
  let(:user) { create :user }

  background do
    Order.aasm.states.map(&:name).each do |state|
      value = create "order_#{state}", user: user
      instance_variable_set "@order_#{state}", value
    end

    login_as user, scope: :user
  end

  scenario '#orders list' do
    visit orders_path

    %w(in_queue in_delivery delivered).each do |state|
      clazz = ".orders-#{state.tr '_', '-'}"
      order = instance_variable_get "@order_#{state}"
      within(clazz) { expect(page).to have_content order.id }
    end
  end

  scenario '#order details' do
    details = @order_in_queue.details
    visit order_path id: @order_in_queue.id

    %i(billing shipping).each do |type|
      address = details.send("#{type}_address").decorate
      check_address_data ".#{type}-address", address
    end

    delivery_method = details.delivery_method.decorate
    check_delivery_method_data delivery_method

    credit_card = details.credit_card.decorate
    check_credit_card_data credit_card
  end

  context '#discount' do
    background { visit order_path id: order.id }

    let(:order) { create :order_with_coupon, user: user }

    scenario '#discount info' do
      expect(page).to have_content I18n.t 'checkout.order_items_info.discount'
    end
  end

  def check_address_data(selector, address)
    check_entity_data address, selector, %i(fullname street city zipcode full_country phone)
  end

  def check_delivery_method_data(delivery_method)
    check_entity_data delivery_method, '.delivery-method', %i(name formatted_price)
  end

  def check_credit_card_data(credit_card)
    check_entity_data credit_card, '.credit-card', %i(formatted_number formatted_date)
  end

  def check_entity_data(entity, selector, fields)
    within(selector) { fields.each { |field| expect(page).to have_content entity.send field } }
  end
end
