class AddMoreGeocodeFieldsToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.string :area_level1
      t.string :area_level2
    end
  end

  def self.down
  end
end
