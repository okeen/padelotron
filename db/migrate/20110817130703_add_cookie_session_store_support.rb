class AddCookieSessionStoreSupport < ActiveRecord::Migration
  def self.up
    change_table :players do |t|
      t.rememberable
    end
  end

  def self.down
  end
end
