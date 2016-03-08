class AddDupliocatedToOffender < ActiveRecord::Migration[5.0]
  def change
    add_column :offenders, :duplicated, :boolean, default: false
  end
end
