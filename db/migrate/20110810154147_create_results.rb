class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :game_id
      t.text :result_sets
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
