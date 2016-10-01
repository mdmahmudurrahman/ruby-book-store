# frozen_string_literal: true
class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :firstname, null: false, index: true
      t.string :lastname, null: false, index: true
      t.string :number, null: false, index: true
      t.string :code, null: false
      t.string :month, null: false
      t.string :year, null: false

      t.timestamps
    end
  end
end
