class AddCustomerReferencesToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.references :customer
    end
  end

  def self.down
  end
end
