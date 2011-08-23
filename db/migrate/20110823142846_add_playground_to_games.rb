class AddPlaygroundToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.references :playground
    end
  end

  def self.down
  end
end
