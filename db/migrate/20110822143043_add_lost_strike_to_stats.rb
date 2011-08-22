class AddLostStrikeToStats < ActiveRecord::Migration
  def self.up
    change_table :stats do |t|
      t.integer :lost_strike
    end

  end

  def self.down
  end
end
