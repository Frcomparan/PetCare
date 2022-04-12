class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false
      t.references :host, null: false
      t.references :home, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.integer :pets_number
      t.decimal :amount

      t.timestamps
    end
    add_foreign_key :reservations, :users, column: :guest_id
    add_foreign_key :reservations, :users, column: :host_id
  end
end
