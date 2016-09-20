# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.decimal :items_price, precision: 10, scale: 2, null: false
      t.string :state, null: false, default: 'in_progress'
      t.datetime :completed_at

      t.references :user, foreign_key: true
      t.references :coupon, foreign_key: true
      t.references :details, references: :order_details

      t.timestamps
    end

    add_foreign_key :orders, :order_details, column: :details_id
  end
end
