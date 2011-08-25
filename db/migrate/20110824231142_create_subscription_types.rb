class CreateSubscriptionTypes < ActiveRecord::Migration
  def self.up
    create_table :subscription_types do |t|
      t.string :name
      t.integer :external_id, :limit => 8
      t.string :external_url

      t.timestamps
    end


    SubscriptionType.create(:name => "free",
                            :external_id => 48733,
                            :external_url => "https://tendel.chargify.com/h/48733/subscriptions/new")
    SubscriptionType.create(:name => "premium", 
                            :external_id => 48734, 
                            :external_url => "https://tendel.chargify.com/h/48734/subscriptions/new")
  end

  def self.down
    drop_table :subscription_types
  end
end
