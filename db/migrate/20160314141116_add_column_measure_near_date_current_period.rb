class AddColumnMeasureNearDateCurrentPeriod < ActiveRecord::Migration[5.0]
  def change
    add_column :measures, :current_period_date, :date
  end
end
