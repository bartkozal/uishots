class AddImageToShots < ActiveRecord::Migration
  def change
    add_column :shots, :image, :string
    add_column :shots, :tmp_image, :string
  end
end
