class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :country
      t.string :state
      t.string :city
      t.string :street

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
