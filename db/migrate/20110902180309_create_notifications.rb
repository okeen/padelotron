class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :player
      t.references :notification_type
      t.text :params
      t.boolean :read, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
