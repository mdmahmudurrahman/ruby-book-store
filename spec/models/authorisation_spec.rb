# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Authorisation, type: :model do
  context 'db' do
    context 'indexes' do
      [:book_id, :author_id].each do |column|
        it "should have index for column '#{column}'" do
          should have_db_index column
        end
      end

      [[:book_id, :author_id], [:author_id, :book_id]].each do |index|
        it "should have unique index '#{index}'" do
          should have_db_index(index).unique true
        end
      end
    end

    context 'columns' do
      [:book_id, :author_id].each do |column|
        it "should have not-null and indexed column '#{column}' type of integer" do
          have_db_column(column).of_type(:integer).with_options \
            null:        false,
            index:       true,
            foreign_key: true
        end
      end
    end
  end

  context 'validation' do
    [:book, :author].each do |field|
      it "requires #{field}" do
        should validate_presence_of field
      end
    end
  end

  context 'association' do
    it 'should have relation with a book' do
      should belong_to :book
    end

    it 'should have relation with an author' do
      should belong_to :author
    end
  end
end
