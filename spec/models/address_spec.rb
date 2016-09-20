# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'db' do
    context 'indexes' do
      %i(city country).each do |column|
        it { should have_db_index column }
      end
    end

    context 'columns' do
      %i(street firstname lastname city country phone zipcode).each do |column|
        it { should have_db_column(column).of_type(:string).with_options null: false }
      end
    end
  end

  context 'validations' do
    %i(street firstname lastname city country phone zipcode).each do |column|
      it { should validate_presence_of column }
    end
  end
end
