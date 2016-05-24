class AddAddressToUnit < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :street, :string
    add_column :units, :district, :string
    add_column :units, :county, :string
    add_column :units, :latitude, :float
    add_column :units, :longitude, :float
  end
end
