class AddFacebookGameRequestIds < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.string :facebook_requets_ids
    end
  end

  def self.down
  end
end
