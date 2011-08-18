class AddFacebookRequestIdToConmfirmations < ActiveRecord::Migration
  def self.up
    change_table :confirmations do |t|
      t.integer :facebook_request_id, :limit => 8
    end
  end

  def self.down
  end
end
