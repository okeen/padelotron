class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.datetime :play_date
      t.string :game_type

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
