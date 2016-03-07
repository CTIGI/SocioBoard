class RemoveColumnsFromOffenders < ActiveRecord::Migration[5.0]
  def change
    remove_column :offenders, :measure_type, :string
    remove_column :offenders, :measure_deadline, :integer
    remove_column :offenders, :start_date_measure, :date
    remove_column :offenders, :end_date_measure, :date
    remove_column :offenders, :measure_situation, :string
    remove_column :offenders, :ammount_end_days, :string
    remove_column :offenders, :article, :string

    add_column :offenders,  :crime_id, :integer
    add_column :offenders, :crimes, :string, array: true, using: "gin", default: "{}"
  end
end
