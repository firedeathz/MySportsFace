class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps null: false
    end
	add_index :participations, :event_id
    add_index :participations, :user_id
	add_index :participations, [:event_id, :user_id], unique: true
  end
end
