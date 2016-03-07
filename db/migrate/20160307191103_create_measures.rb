class CreateMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :measures do |t|
      t.date :start_date_measure
      t.date :end_date_measure
      t.string :measure_type
      t.integer :measure_deadline
      t.string :measure_situation
      t.string :ammount_end_days
      t.references :offender, foreign_key: true

      t.timestamps
    end
  end
end
