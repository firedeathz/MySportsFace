class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.time :timeloc
      t.string :description
      t.references :event, index: true, foreign_key: true

      t.timestamps
    end
	add_index :schedule_entries, [:event_id, :timeloc]
  end
end
