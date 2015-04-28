class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.text :description
      t.references :organization, index: true

      t.timestamps
    end
  end
end
