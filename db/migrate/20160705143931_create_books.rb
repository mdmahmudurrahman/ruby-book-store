# frozen_string_literal: true
class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, null: false, index: true
      t.boolean :visible, null: false, default: true
      t.text :description_short, null: false, default: '(No description)'
      t.text :description_full, null: false, default: '(No description)'
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :count, null: false
      t.string :cover

      t.timestamps
    end

    add_index :books, :visible, where: 'visible'
  end
end
