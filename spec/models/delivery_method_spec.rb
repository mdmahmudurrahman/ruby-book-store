# frozen_string_literal: true
describe DeliveryMethod, type: :model, focus: true do
  context 'db' do
    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options null: false }
      it { should have_db_column(:active).of_type(:boolean).with_options null: false, default: true }
      it { should have_db_column(:default).of_type(:boolean).with_options null: false, default: false }
      it { should have_db_column(:price).of_type(:decimal).with_options null: false, scale: 2, precision: 10 }
    end
  end

  context 'validations' do
    %i(name price).each do |property|
      it { should validate_presence_of property }
    end

    it { should validate_inclusion_of(:price).in_range 1..100 }
  end
end
