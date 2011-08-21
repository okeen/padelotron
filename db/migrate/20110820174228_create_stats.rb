class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.string :statable_type
      t.integer :statable_id
      t.integer :wins, :default => 0
      t.integer :lost, :default => 0
      t.float :win_percent, :default => 0
      t.integer :win_strike, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :stats
  end
end
