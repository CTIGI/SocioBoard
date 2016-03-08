class CreateCrimesOffenders < ActiveRecord::Migration[5.0]
  def change
    create_table :crimes_offenders do |t|
      t.references :crime, index: true
      t.references :offender, index: true

      t.timestamps
    end
  end
end
