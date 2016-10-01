# frozen_string_literal: true
describe Order, type: :model do
  context '#database' do
    context '#indexes' do
      it { should have_db_index :user_id }
    end

    context '#columns' do
      it { should have_db_column(:completed_at).of_type :datetime }
      it { should have_db_column(:user_id).of_type(:integer).with_options index: true, foreign_key: true }
      it { should have_db_column(:state).of_type(:string).with_options null: false, default: 'in_progress' }

      %i(total_price items_price).each do |column|
        it { should have_db_column(column).of_type(:decimal).with_options null: false, precision: 10, scale: 2 }
      end
    end
  end

  context '#validations' do
    it { should validate_presence_of :state }
  end

  context '#associations' do
    it { should belong_to :user }
    it { should have_many(:items).dependent :destroy }
    it { should belong_to(:details).dependent(:destroy).class_name OrderDetail }

    it 'should create order with details' do
      expect { create :order }.to change { OrderDetail.count }.by 1
    end

    it 'should delete order items and details' do
      create(:order_with_items).destroy

      [Order, OrderItem, OrderDetail].each do |entity|
        expect(entity.count).to eq 0
      end
    end
  end
end
