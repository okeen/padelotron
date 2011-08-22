class CreatePlaygrounds < ActiveRecord::Migration
  def self.up
    create_table :playgrounds do |t|
      t.string :name
      t.string :sport
      t.integer :number
      t.references :place

      t.timestamps
    end
  end

  def self.down
    drop_table :playgrounds
  end
end
