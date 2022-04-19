class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :guest, null: false, foreign_key: { to_table: :users}
      t.references :home, null: false, foreign_key: true
      t.decimal :score, precision: 5, scale: 2
      t.string :comment

      t.timestamps
    end
  end
end
