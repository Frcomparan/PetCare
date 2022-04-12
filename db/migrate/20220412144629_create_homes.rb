class CreateHomes < ActiveRecord::Migration[7.0]
  def change
    create_table :homes do |t|
      t.string :title
      t.string :address
      t.string :description
      t.decimal :price
      t.decimal :score, precision: 4, scale: 2, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
