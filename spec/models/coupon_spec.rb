# frozen_string_literal: true
describe Coupon, type: :model do
  context '#database' do
    context '#columns' do
      it { should have_db_column(:discount).of_type(:integer).with_options null: false }
      it { should have_db_column(:name).of_type(:string).with_options null: false, index: true }
      it { should have_db_column(:available).of_type(:boolean).with_options null: false, default: true }
    end

    context '#indexes' do
      it { should have_db_index :name }
    end
  end
end
