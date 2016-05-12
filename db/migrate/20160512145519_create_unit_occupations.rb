class CreateUnitOccupations < ActiveRecord::Migration[5.0]
  def change
    create_table :unit_occupations do |t|
      t.references :unit, foreign_key: true, index: true
      t.date :day
      t.integer :occupation

      t.timestamps
    end
  end
end
