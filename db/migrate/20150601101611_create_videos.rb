class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.string :author
      t.string :duration
      t.integer :likes
      t.integer :dislikes
	  t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
