class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
	  t.string :atom_id
      t.string :author
      t.string :title
	  t.text :content
      t.text :description
	  t.string :url
      t.references :organization, index: true

      t.timestamps
    end
  end
end
