class AddFileToUnit < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :photo, :string
  end
end
