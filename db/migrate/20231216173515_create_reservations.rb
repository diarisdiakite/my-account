# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.integer :hourly_fee
      t.integer :total_amount_payable
      t.integer :duration
      t.timestamps
    end
  end
end
