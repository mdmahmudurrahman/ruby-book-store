# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'db' do
    context 'indexes' do
      %i(number firstname lastname).each do |column|
        it { should have_db_index column }
      end
    end

    context 'columns' do
      %i(number month year firstname lastname code).each do |column|
        it { should have_db_column(column).of_type(:string).with_options null: false }
      end
    end
  end

  context 'validations' do
    %i(number month year code firstname lastname).each do |property|
      it { should validate_presence_of property }
    end
  end
end
