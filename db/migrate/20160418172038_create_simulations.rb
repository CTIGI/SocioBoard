class CreateSimulations < ActiveRecord::Migration[5.0]
  def change
    create_table :simulations do |t|
      t.string :name
      t.text :data
      t.text :div_text
      t.references :user, index: true

      t.timestamps
    end
  end
end
