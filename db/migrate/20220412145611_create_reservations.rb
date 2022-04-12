class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :guest_id, null: false
      t.references :host_id, null: false
      t.references :publication, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.integer :pets_number
      t.decimal :amoun

      t.timestamps
    end
    add_foreign_key :reservations, :users, column: :guest_id
    add_foreign_key :reservations, :users, column: :host_id
  end
end
