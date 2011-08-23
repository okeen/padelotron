class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
