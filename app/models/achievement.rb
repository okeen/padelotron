class Achievement < ActiveRecord::Base
  belongs_to :stat
  belongs_to :achievement_type

  delegate :name, :to => :achievement_type
  delegate :nature, :to => :achievement_type
  delegate :group, :to => :achievement_type

  scope :with_type, lambda { |achievement_type|
    joins(:achievement_type).where("name = ?", achievement_type)
  }

  def Achievement.update_achievements_for(statable)
    new_achievements= []
    if (statable.class == Player)
      new_achievements= self.update_achievements_for_player(statable)
    else
      new_achievements= self.update_achievements_for_team(statable)
    end
    puts "Achiev.New for #{statable.class}##{statable.id}: #{new_achievements}"
  end

  private

  def self.update_achievements_for_player(player)
    new_achievements = []
    if (player.stat.win_strike == 3)
      new_achievements <<  player.stat.achievements.create(AchievementType.STRIKED)
    end

    if (player.stat.win_strike == 5)
      new_achievements << player.stat.achievements.create(AchievementType.HOT)
    end
    new_achievements
  end

  def self.update_achievements_for_team(team)
    new_achievements = []
    if (team.stat.win_strike == 3)
      new_achievements << team.stat.achievements.create(AchievementType.STRIKED)
    end

    if (team.stat.win_strike == 5)
      new_achievements << team.stat.stat.achievements.create(AchievementType.HOT)
    end
    new_achievements
  end

end
