# frozen_string_literal: true
describe Author, type: :model do
  context '#database' do
    context '#indexes' do
      %i(firstname lastname).each do |column|
        it { should have_db_index column }
      end
    end

    context '#columns' do
      %i(firstname lastname).each do |column|
        it { should have_db_column(column).of_type(:string).with_options null: false, index: true }
      end

      it { should have_db_column(:description).of_type(:text).with_options null: false, default: '(No description)' }
    end
  end

  context '#validation' do
    %i(firstname lastname).each do |field|
      it { should validate_presence_of field }
    end
  end

  context '#associations' do
    it { should have_many(:books).through(:authorisations).dependent :restrict_with_error }
  end
end
