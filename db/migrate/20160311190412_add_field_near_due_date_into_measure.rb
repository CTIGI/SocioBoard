class AddFieldNearDueDateIntoMeasure < ActiveRecord::Migration[5.0]
  def change
    add_column :measures, :near_due_date, :boolean, default: false
  end
end
