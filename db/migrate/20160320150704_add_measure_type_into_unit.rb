class AddMeasureTypeIntoUnit < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :measure_unit_type, :integer
  end
end
