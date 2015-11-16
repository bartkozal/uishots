class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.string :name
      t.string :url
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
