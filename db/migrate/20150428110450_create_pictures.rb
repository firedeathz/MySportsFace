class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
	  t.references :event, index: true, foreign_key: true

      t.timestamps
    end
	add_index :pictures, [:event_id, :created_at]
  end
end
