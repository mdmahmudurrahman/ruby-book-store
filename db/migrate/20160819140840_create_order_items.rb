# frozen_string_literal: true
class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false, default: 1
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :total, precision: 10, scale: 2, null: false

      t.references :book, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
