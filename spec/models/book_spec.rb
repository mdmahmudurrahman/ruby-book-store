# frozen_string_literal: true
describe Book, type: :model do
  context '#database' do
    context '#indexes' do
      %i(title visible).each do |column|
        it { should have_db_index column }
      end
    end

    context '#columns' do
      it { should have_db_column(:cover).of_type :string }
      it { should have_db_column(:count).of_type(:integer).with_options null: false }
      it { should have_db_column(:title).of_type(:string).with_options null: false, index: true }
      it { should have_db_column(:price).of_type(:decimal).with_options precision: 10, scale: 2, null: false }
      it { should have_db_column(:visible).of_type(:boolean).with_options null: false, default: true, index: true }

      %i(description_short description_full).each do |column|
        it { should have_db_column(column).of_type(:text).with_options null: false, default: '(No description)' }
      end
    end
  end

  context '#validation' do
    %i(title price count authors categories).each do |field|
      it { should validate_presence_of field }
    end

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to 0.01 }
    it { should validate_numericality_of(:count).only_integer.is_greater_than_or_equal_to 0 }
  end

  context '#associations' do
    %i(authorisations categorisations reviews).each do |association|
      it { should have_many(association).dependent :destroy }
    end

    it { should have_many(:authors).through :authorisations }
    it { should have_many(:categories).through :categorisations }
    it { should have_many(:order_items).dependent :restrict_with_error }
  end
end
