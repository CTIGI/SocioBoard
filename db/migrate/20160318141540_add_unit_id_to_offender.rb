class AddUnitIdToOffender < ActiveRecord::Migration[5.0]
  def change
    add_column :offenders, :unit_id, :integer
    remove_column :offenders, :unit, :string
    add_index :offenders, :unit_id
  end
end
