# frozen_string_literal: true
class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :credit_card, foreign_key: true
      t.references :delivery_method, foreign_key: true

      t.references :billing_address, references: :addresses
      t.references :shipping_address, references: :addresses

      t.string :step, null: false, default: 'address', index: true

      t.timestamps
    end

    add_foreign_key :order_details, :addresses, column: :billing_address_id
    add_foreign_key :order_details, :addresses, column: :shipping_address_id
  end
end
