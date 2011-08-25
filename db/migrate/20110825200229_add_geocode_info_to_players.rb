class AddGeocodeInfoToPlayers < ActiveRecord::Migration
  def self.up
    change_table :players do |t|
     t.float :latitude
      t.float :longitude
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :area_level1
      t.string :area_level2
      t.string :full_address
    end
  end

  def self.down
  end
end
