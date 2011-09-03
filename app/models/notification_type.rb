class NotificationType < ActiveRecord::Base
  belongs_to :notification

  scope :named, lambda {|name| where('name = ?', name)}


  def self.create_all_notification_types
    NotificationType.create(:name => "new_player")
    NotificationType.create(:name => "new_team")
    NotificationType.create(:name => "team_confirmed")
    NotificationType.create(:name => "team_rejected")
    NotificationType.create(:name => "new_game")
    NotificationType.create(:name => "game_confirmed")
    NotificationType.create(:name => "game_rejected")
    NotificationType.create(:name => "new_result")
    NotificationType.create(:name => "result_confirmed")
    NotificationType.create(:name => "result_rejected")

  end
  create_all_notification_types if self.all.blank?;


  def NotificationType.NEW_PLAYER(player)
    {
      :notification_type_id => NotificationType.named("new_player").first.id,
      :params => {
        :title => "Welcome to Padelotron, #{player.name}",
        :message => "As your first actions, yo can create a new team, invite friends or check today's games in your area",
        :urgent => true
      }
    }
  end

  def NotificationType.NEW_TEAM(team)
    {
      :notification_type_id => NotificationType.named("new_team").first.id,
      :params => {
        :title => "New Team Request",
        :message => "You have received an offer to join the team #{team.name}, with #{team.players.collect(&:name)}",
       :confirmable_id => team.id,
       :confirmable_type => "Team",
       :accept_code => team.confirmations.to_accept.first.code,
       :reject_code => team.confirmations.to_reject.first.code,
       }
    }
  end

  def NotificationType.TEAM_CONFIRMED(team)
    {
      :notification_type_id => NotificationType.named("team_confirmed").first.id,
      :params => {
        :title => "Team Joined",
        :message => "You have joined the team #{team.name}, with #{team.players.collect(&:name)}"
      }
    }
  end

  def NotificationType.TEAM_REJECTED(team)
    {
      :notification_type_id => NotificationType.named("team_confirmed").first.id,
      :params => {
        :title => "Team Rejecetd",
        :message => "The team #{team.name}, has been rejected"
      }
    }
  end

  def NotificationType.NEW_GAME(game)
    {
      :notification_type_id => NotificationType.named("new_game").first.id,
      :params => {
        :title => "Game Request",
        :message => "You have received an offer to play a game between the teams #{game.team1.name} and #{game.team2.name} for #{game.play_date} "
      }
    }
  end

  def NotificationType.GAME_CONFIRMED(game)
    {
      :notification_type_id => NotificationType.named("game_confirmed").first.id,
      :params => {
        :title => "Game confirmed",
        :message => "The game between the teams #{game.team1.name} and #{game.team2.name} for #{game.play_date} has been confirmed"
      }
    }
  end
  def NotificationType.GAME_REJECTED(game)
    {
      :notification_type_id => NotificationType.named("game_confirmed").first.id,
      :params => {
        :title => "Game rejected",
        :message => "The game between the teams #{game.team1.name} and #{game.team2.name} for #{game.play_date} has been rejected"
      }
    }
  end
  def NotificationType.NEW_RESULT(result)
    {
      :notification_type_id => NotificationType.named("new_result").first.id,
      :params => {
        :title => "Result confirmation request",
        :message => "#{result.winner.name } claims that they won the game played against your team"
      }
    }
  end
  def NotificationType.RESULT_CONFIRMED(result)
    {
      :notification_type_id => NotificationType.named("result_confirmed").first.id,
      :params => {
        :title => "Result confirmed",
        :message => "Victory of #{result.winner.name} against confirmed"
      }
    }
  end
  def NotificationType.RESULT_REJECTED(result)
    {
      :notification_type_id => NotificationType.named("result_confirmed").first.id,
      :params => {
        :title => "Result rejected",
        :message => "The result has been rejected by the supposelly loser team."
      }
    }
  end
end
