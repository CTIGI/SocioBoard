class RemoveCrimesFromOffender < ActiveRecord::Migration[5.0]
  def change
    remove_column :offenders, :crimes, :string
  end
end
