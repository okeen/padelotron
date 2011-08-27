class AddRegistrationRequiredToPlaygrounds < ActiveRecord::Migration
  def self.up
    change_table :playgrounds do |t|
      t.boolean :reservation_required
    end
    change_table :places do |t|
      t.boolean :reservation_required
    end
  end

  def self.down
  end
end
