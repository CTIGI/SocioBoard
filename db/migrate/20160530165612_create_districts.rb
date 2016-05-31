class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
