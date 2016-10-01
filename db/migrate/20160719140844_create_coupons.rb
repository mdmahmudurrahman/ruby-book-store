# frozen_string_literal: true
class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :name, null: false, index: true
      t.integer :discount, null: false
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
