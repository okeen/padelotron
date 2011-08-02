class AddStatusToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.string :status, :default => 'new'
    end
    Game.update_all ["status = ?", 'confirmed']
  end

  def self.down
  end
end
