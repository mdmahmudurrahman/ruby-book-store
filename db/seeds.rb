# frozen_string_literal: true

Cloudinary::Api.delete_all_resources type: :upload

user = FactoryGirl.create :user, email: 'user@example.com', password: '123456'

FactoryGirl.create :admin, email: 'admin@example.com', password: '123456'

###=> author creation

author = FactoryGirl.create :author

###=> books creation

Dir[Rails.root.join 'public', 'books', 'covers', '*'].each do |cover|
  FactoryGirl.create :book, cover: Pathname.new(cover).open, authors: [author]
end

book = Book.where('count > ?', 0).first

###=> order item creation

item = OrderItem.new book: book

###=> order creation

order = Order.new user: user
order.add_item item

%i(in_queue in_delivery delivered).each do |state|
  FactoryGirl.create "order_#{state}", user: user
end

###=> order details population

details = order.details

details.credit_card = FactoryGirl.create :credit_card

%i(billing shipping).each do |type|
  details.send "#{type}_address=", FactoryGirl.create(:address)
end

order.save!

###=> delivery method creation

{ 'UPS Ground': 5.00, 'UPS Two Day': 10.00, 'UPS One Day': 15.00 }.each do |name, price|
  DeliveryMethod.create! name: name, price: price
end
