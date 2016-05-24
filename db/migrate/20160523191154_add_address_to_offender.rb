class AddAddressToOffender < ActiveRecord::Migration[5.0]
  def change
    add_column :offenders, :street, :string
    add_column :offenders, :district, :string
    add_column :offenders, :address_county, :string

    add_column :offenders, :secondary_street, :string
    add_column :offenders, :secondary_district, :string
    add_column :offenders, :secondary_address_county, :string

    add_column :offenders, :latitude, :float
    add_column :offenders, :longitude, :float
  end
end
