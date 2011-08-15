class AddImagesToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :image_file_name,    :string
    add_column :teams, :image_content_type, :string
    add_column :teams, :image_file_size,    :integer
    add_column :teams, :image_updated_at,   :datetime
  end

  def self.down
    remove_column :teams, :image_file_name,    :string
    remove_column :teams, :image_content_type, :string
    remove_column :teams, :image_file_size,    :integer
    remove_column :teams, :image_updated_at,   :datetime
  end
end
