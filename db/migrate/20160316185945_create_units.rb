class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :name
      t.integer :capacity
      t.integer :occupied

      t.timestamps
    end
  end
end
