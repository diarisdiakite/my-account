# frozen_string_literal: true

class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :icon
      t.string :description
      t.string :facebook
      t.string :twitter
      t.string :website
      t.integer :finance_fee
      t.integer :option_to_purchase_fee
      t.integer :total_amount_payable
      t.integer :duration

      t.timestamps
    end
  end
end
