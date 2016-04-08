class CreateMeasureTypesUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :measure_types_units do |t|
      t.references :measure_type, index: true
      t.references :unit, index: true
    end
  end
end
