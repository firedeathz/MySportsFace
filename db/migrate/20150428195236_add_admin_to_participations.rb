class AddAdminToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :admin, :boolean
  end
end
