# frozen_string_literal: true
describe Category, type: :model do
  context '#database' do
    context '#indexes' do
      it { should have_db_index(:name).unique }
    end

    context '#columns' do
      it { should have_db_column(:name).of_type(:string).with_options null: false, index: true }
    end
  end

  context '#attributes' do
    it { expect(build(:category, name: 'name')).to have_attributes name: 'name' }
  end

  context '#validation' do
    subject { create :category }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context '#associations' do
    it { should have_many(:books_visible).through(:categorisations).source :book }
    it { should have_many(:books).through(:categorisations).dependent :restrict_with_error }
  end
end
