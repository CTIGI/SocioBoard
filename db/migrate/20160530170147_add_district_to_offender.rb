class AddDistrictToOffender < ActiveRecord::Migration[5.0]
  def change
    remove_column :offenders, :district, :string

    add_column :offenders, :district_id, :integer, index: true
  end
end
