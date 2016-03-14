class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.integer  "ctigi_auth_uid"
      t.string   "ctigi_auth_access_token"
      t.timestamps null: false
      t.timestamps
    end

    add_index :users, :email,                unique: true
  end
end
