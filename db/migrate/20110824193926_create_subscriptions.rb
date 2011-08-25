class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.references :customer
      t.boolean :payment_to_date, :default => false
      t.boolean :active, :default => true
      t.datetime :last_payment
      t.integer :external_id, :limit => 8
      t.integer :external_customer_id, :limit => 8
      t.integer :external_signup_payment_id, :limit => 8
      t.float :total_revenue, :default => 0

      t.references :subscription_type

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
