class AchievementType < ActiveRecord::Base

  scope :named, lambda {|name| where('name = ?', name)}

  def self.create_all_achievement_types
    AchievementType.create(:name => "striked", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "hot", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "padawan", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "initiated", :nature => "positive", :group => "basic")
    AchievementType.create(:name => "buzzed", :nature => "negative", :group => "basic")
    AchievementType.create(:name => "cold", :nature => "negative", :group => "basic")
  end

  if self.all.blank?
    self.create_all_achievement_types
  end

  def AchievementType.STRIKED
    {
      :achievement_type_id => AchievementType.named("striked").first.id,
      :message => "You got the striked achievement"
    }
  end

  def AchievementType.HOT
    {
      :achievement_type_id => AchievementType.named("hot").first.id,
      :message => "You got the hot achievement"
    }
  end

  private

  
end
