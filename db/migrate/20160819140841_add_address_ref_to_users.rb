# frozen_string_literal: true
class AddAddressRefToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :billing_address, index: true, foreign_key: { to_table: :addresses }
    add_reference :users, :shipping_address, index: true, foreign_key: { to_table: :addresses }
  end
end
