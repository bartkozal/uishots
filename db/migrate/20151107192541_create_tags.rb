class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :taggables do |t|
      t.belongs_to :tag, index: true, foreign_key: true
      t.belongs_to :shot, index: true, foreign_key: true
      t.timestamps
    end
  end
end
