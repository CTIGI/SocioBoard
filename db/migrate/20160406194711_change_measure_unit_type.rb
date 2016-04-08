class ChangeMeasureUnitType < ActiveRecord::Migration[5.0]
  def change
    remove_column :units, :measure_unit_type, :integer
  end
end
