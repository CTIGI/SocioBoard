class AddColumnCurrentPeriodIntoMeasure < ActiveRecord::Migration[5.0]
  def change
    add_column :measures, :current_period, :integer
  end
end
