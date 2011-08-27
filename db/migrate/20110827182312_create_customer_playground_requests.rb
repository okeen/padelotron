class CreateCustomerPlaygroundRequests < ActiveRecord::Migration
  def self.up
    create_table :customer_playground_requests do |t|
      t.references :game
      t.references :playground
      t.string :accept_code
      t.string :reject_code
      t.string :status, :default => 'new'

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_playground_requests
  end
end
