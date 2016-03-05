class CreateOffenders < ActiveRecord::Migration[5.0]
  def change
    create_table :offenders do |t|
      t.string  :id_citizen
      t.string  :unit
      t.string  :name
      t.date    :birth_date
      t.integer :age
      t.string  :recurrent
      t.string  :origin_county
      t.string  :article
      t.string  :measure_type
      t.integer :measure_deadline
      t.date    :start_date_measure
      t.date    :end_date_measure
      t.string  :measure_situation
      t.string  :ammount_end_days
      t.timestamps
    end
  end
end
