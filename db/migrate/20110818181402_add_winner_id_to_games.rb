class AddWinnerIdToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.integer :winner_team_id
    end

  end

  def self.down
  end
end
