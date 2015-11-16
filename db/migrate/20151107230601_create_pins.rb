class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :shot, index: true, foreign_key: true
      t.timestamps
    end
  end
end
