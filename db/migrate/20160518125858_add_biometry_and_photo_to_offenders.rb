class AddBiometryAndPhotoToOffenders < ActiveRecord::Migration[5.0]
  def change
    add_column :offenders, :has_photo, :boolean
    add_column :offenders, :has_biometry, :boolean
  end
end
