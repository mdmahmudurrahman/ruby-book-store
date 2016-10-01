# frozen_string_literal: true
describe OrderItem, type: :model do
  subject { OrderItem.new attributes_for :order_item }

  context '#database' do
    context '#indexes' do
      %i(book_id order_id).each do |column|
        it { should have_db_index column }
      end
    end

    context '#columns' do
      it { should have_db_column(:quantity).of_type(:integer).with_options null: false, default: 1 }

      %i(price total).each do |column|
        it { should have_db_column(column).of_type(:decimal).with_options null: false, precision: 10, scale: 2 }
      end

      %i(book_id order_id).each do |column|
        it { should have_db_column(column).of_type(:integer).with_options null: false, index: true, foreign_key: true }
      end
    end
  end

  context '#validations' do
    %i(quantity price total book).each do |field|
      it { should validate_presence_of field }
    end

    it { should validate_numericality_of(:quantity).is_greater_than(0).only_integer }
  end

  context '#associations' do
    %i(book order).each do |association|
      it { should belong_to association }
    end
  end
end
