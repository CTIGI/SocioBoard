class CreateRolesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_users do |t|
      t.references :user, index: true
      t.references :role, index: true
    end
  end
end
