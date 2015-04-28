class AddCreatorToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :creator, :boolean
  end
end
