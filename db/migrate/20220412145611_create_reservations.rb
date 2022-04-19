class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false, foreign_key: { to_table: :users}
      t.references :host, null: false, foreign_key: { to_table: :users}
      t.references :home, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.integer :pets_number
      t.decimal :amount

      t.timestamps
    end
  end
end
