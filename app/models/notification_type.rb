class NotificationType < ActiveRecord::Base
  belongs_to :notification

  scope :named, lambda {|name| where('name = ?', name)}


  def self.create_all_notification_types
    NotificationType.create(:name => "new_player")
    NotificationType.create(:name => "new_team")
    NotificationType.create(:name => "team_accepted")
    NotificationType.create(:name => "new_game")
    NotificationType.create(:name => "game_accepted")
    NotificationType.create(:name => "new_result")
    NotificationType.create(:name => "result_accepted")
  end
  create_all_notification_types if self.all.blank?;


  def NotificationType.NEW_PLAYER
    {
      :notification_type_id => NotificationType.named("new_player").first.id,
      :params => {
        :title => "Welcome to Padelotron",
        :message => "As your first actions, yo can create a new team, invite friends or check today's games in your area",
        :urgent => true
      }
    }
  end

  def NotificationType.NEW_TEAM
    {
      :notification_type_id => NotificationType.named("new_team").first.id,
      :params => {
        :title => "New Team Request",
        :message => "You have received an offer to join a team"}
    }
  end

  def NotificationType.TEAM_ACCEPTED
    {
      :notification_type_id => NotificationType.named("team_accepted").first.id,
      :params => {
        :title => "Team Joined",
        :message => "You have joined a new team"
      }
    }
  end

  def NotificationType.NEW_GAME
    {
      :notification_type_id => NotificationType.named("new_game").first.id,
      :params => {
        :title => "Team Joined",
        :message => "You have joined a new team"
      }
    }
  end

end
