class AddColumncToHome < ActiveRecord::Migration[7.0]
  def change
    add_column :homes, :latitude, :decimal
    add_column :homes, :longitude, :decimal
  end
end
