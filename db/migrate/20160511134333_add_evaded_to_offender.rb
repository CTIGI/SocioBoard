class AddEvadedToOffender < ActiveRecord::Migration[5.0]
  def change
    add_column :offenders, :evaded, :boolean, default: false
    add_column :offenders, :evasion_date, :date
  end
end
