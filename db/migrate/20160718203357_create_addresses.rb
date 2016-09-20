# frozen_string_literal: true
class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :city, null: false, index: true
      t.string :country, null: false, index: true
      t.string :phone, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
  end
end
