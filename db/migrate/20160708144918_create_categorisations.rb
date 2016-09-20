# frozen_string_literal: true
class CreateCategorisations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorisations do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.index [:book_id, :category_id], unique: true
      t.index [:category_id, :book_id], unique: true
    end
  end
end
