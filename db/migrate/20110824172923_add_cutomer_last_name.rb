class AddCutomerLastName < ActiveRecord::Migration
  def self.up
    change_table :customers do |t|
      t.string :last_name
    end
  end

  def self.down
  end
end
