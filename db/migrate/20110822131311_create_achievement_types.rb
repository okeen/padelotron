class CreateAchievementTypes < ActiveRecord::Migration
  def self.up
    create_table :achievement_types do |t|
      t.string :name
      t.string :nature
      t.string :group
      t.timestamps
    end

    AchievementType.create(:name => "striked", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "hot", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "padawan", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "initiated", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "buzzed", :nature => "negative", :group => "basic")
    AchievementType.create(:name => "cold", :nature => "negative", :group => "basic")

  end

  def self.down
    drop_table :achievement_types
  end
end
