class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.references :stat
      t.references :achievement_type
      t.boolean :read, :default => false
      t.text :message
      t.datetime :expires

      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
