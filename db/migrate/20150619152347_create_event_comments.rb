class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.text :body
      t.string :author

      t.timestamps null: false
    end
    add_foreign_key :event_comments, :events
    add_foreign_key :event_comments, :users
  end
end
