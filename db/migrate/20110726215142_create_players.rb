class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.database_authenticatable
      t.integer :facebook_id, :limit => 8

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
