# frozen_string_literal: true
class CreateDeliveryMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_methods do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.boolean :default, null: false, default: false
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
