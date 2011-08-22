class AddLostStrikeToStats < ActiveRecord::Migration
  def self.up
    change_table :stats do |t|
      t.integer :lost_strike, :default => 0
    end

  end

  def self.down
  end
end
