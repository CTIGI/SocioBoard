class AddMinMaxAgeToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :min_age, :integer, default: 12
    add_column :units, :max_age, :integer, default: 22
  end
end
