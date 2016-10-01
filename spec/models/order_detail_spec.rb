# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  PROPERTIES = [
    :credit_card, :delivery_method,
    :billing_address, :shipping_address
  ].freeze

  COLUMN_IDS = PROPERTIES.map do |column|
    "#{column}_id".to_sym
  end

  context 'db' do
    context 'indexes' do
      COLUMN_IDS.each do |column|
        it { should have_db_index column }
      end

      it { should have_db_index :step }
    end

    context 'columns' do
      COLUMN_IDS.each do |column|
        it { should have_db_column(column).of_type :integer }
      end

      it { should have_db_column(:step).of_type(:string).with_options null: false, index: true }
    end
  end

  context 'associations' do
    PROPERTIES.each do |column|
      it { should belong_to column }
    end
  end
end
