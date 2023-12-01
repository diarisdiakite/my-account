class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.string :bio
      t.integer :recipes_counter

      t.timestamps
    end
  end
end
