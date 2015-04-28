class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.references :article, index: true
	  t.references :user, index: true

      t.timestamps
    end
	add_index :comments, [:user_id, :article_id, :created_at]
  end
end
