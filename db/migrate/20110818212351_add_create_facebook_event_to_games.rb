class AddCreateFacebookEventToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.boolean :create_facebook_event
      t.integer :facebook_event_id, :limit => 8
    end
  end

  def self.down
  end
end
