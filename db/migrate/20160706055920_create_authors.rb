# frozen_string_literal: true
class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :firstname, null: false, index: true
      t.string :lastname, null: false, index: true
      t.text :description, null: false, default: '(No description)'

      t.timestamps
    end
  end
end
