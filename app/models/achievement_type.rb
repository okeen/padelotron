class AchievementType < ActiveRecord::Base

  scope :named, lambda {|name| where('name = ?', name)}

  scope :by_group, lambda {|group| where('group = ?', group)}

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

  def AchievementType.BUZZED
    {
      :achievement_type_id => AchievementType.named("buzzed").first.id,
      :message => "You got the buzzed achievement"
    }
  end

  def AchievementType.COLD
    {
      :achievement_type_id => AchievementType.named("cold").first.id,
      :message => "You got the cold achievement"
    }
  end

  private

  
end
