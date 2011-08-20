class AddFacebookRequestIdToConmfirmations < ActiveRecord::Migration
  def self.up
    change_table :confirmations do |t|
      t.text :facebook_request_id
    end
  end

  def self.down
  end
end
