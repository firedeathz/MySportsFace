class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
	  t.string :title
      t.string :url
      t.string :status
	  t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
