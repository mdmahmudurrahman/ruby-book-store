# frozen_string_literal: true
class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :text, null: false
      t.integer :mark, null: false
      t.boolean :visible, null: false, default: false
      t.boolean :new, null: false, default: true

      t.timestamps
    end
  end
end
