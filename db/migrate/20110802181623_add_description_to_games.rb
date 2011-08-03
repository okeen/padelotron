class AddDescriptionToGames < ActiveRecord::Migration
  def self.up
     change_table :games do |t|
      t.string :description, :default => ''
    end
  end

  def self.down
  end
end
