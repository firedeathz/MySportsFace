class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :atom_id
      t.string :title
      t.string :url
	  t.string :description
      t.string :content
	  t.references :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
