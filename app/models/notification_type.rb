class NotificationType < ActiveRecord::Base
  belongs_to :notification

  scope :named, lambda {|name| where('name = ?', name)}


  def self.create_all_notification_types
    NotificationType.create(:name => "new_player")
    NotificationType.create(:name => "new_team")
    NotificationType.create(:name => "team_confirmed")
    NotificationType.create(:name => "new_game")
    NotificationType.create(:name => "game__confirmed")
    NotificationType.create(:name => "new_result")
    NotificationType.create(:name => "result_confirmed")
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

  def NotificationType.TEAM_CONFIRMED
    {
      :notification_type_id => NotificationType.named("team_confirmed").first.id,
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
        :title => "Game Request",
        :message => "You have received a game offer"
      }
    }
  end

  def NotificationType.GAME_CONFIRMED
    {
      :notification_type_id => NotificationType.named("game_confirmed").first.id,
      :params => {
        :title => "Game confirmed",
        :message => "You have a new confirmed game"
      }
    }
  end
  def NotificationType.NEW_RESULT
    {
      :notification_type_id => NotificationType.named("new_result").first.id,
      :params => {
        :title => "Result confirmation request",
        :message => "You have received a request to confirm the result"
      }
    }
  end
  def NotificationType.RESULT_CONFIRMED
    {
      :notification_type_id => NotificationType.named("result_confirmed").first.id,
      :params => {
        :title => "Result confirmed",
        :message => ""
      }
    }
  end
end
