class RemoveNearDueDateIntoMeasure < ActiveRecord::Migration[5.0]
  def change
    remove_column :measures, :near_due_date
  end
end
