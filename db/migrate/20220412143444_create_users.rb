class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.date :birthdate
      t.string :phone
      t.string :address
      t.integer :role, :default => 0

      t.timestamps
    end
  end
end
