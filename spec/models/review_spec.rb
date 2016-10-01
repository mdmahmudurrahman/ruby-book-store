# frozen_string_literal: true
describe Review, type: :model do
  context '#database' do
    context '#columns' do
      it { should have_db_column(:text).of_type(:string).with_options null: false }
      it { should have_db_column(:mark).of_type(:integer).with_options null: false }
    end
  end

  context '#validation' do
    %i(text mark).each do |field|
      it { should validate_presence_of field }
    end

    it do
      should validate_numericality_of(:mark).only_integer
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
    end
  end

  context '#associations' do
    %i(book user).each do |association|
      it { should belong_to association }
    end
  end
end
