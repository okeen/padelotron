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
    accept_code = team.confirmations.to_accept.first.code
    reject_code = team.confirmations.to_reject.first.code

    {
      :notification_type_id => NotificationType.named("new_team").first.id,
      :params => {
        :title => "New Team Request",
        :message => "You have received an offer to join the team #{team.name}, with #{team.players.collect(&:name)}<BR/>" +
                   "Do you want to <a href='/confirmations/#{accept_code}'>ACCEPT</a> or <a href='/confirmations/#{reject_code}'>REJECT</a> the offer?",
       :confirmable_id => team.id,
       :confirmable_type => "Team",
       :accept_code => accept_code,
       :reject_code => reject_code,
       }
    }
  end

  def NotificationType.TEAM_CONFIRMED(team)
    {
      :notification_type_id => NotificationType.named("team_confirmed").first.id,
      :params => {
        :title => "Team Joined",
        :message => "You have joined the team <a href='/teams/#{team.id}'>#{team.name}</a>, with #{team.players.collect(&:name)}"
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
    accept_code = game.confirmations.to_accept.first.code
    reject_code = game.confirmations.to_reject.first.code

    {
      :notification_type_id => NotificationType.named("new_game").first.id,
      :params => {
        :title => "Game Request",
        :message => "You have received an offer to play a game between the teams #{game.team1.name} and #{game.team2.name}, on #{game.play_date} "+
                     "Do you want to <a href='/confirmations/#{accept_code}'>ACCEPT</a> or <a href='/confirmations/#{reject_code}'>REJECT</a> the offer?",
        :confirmable_id => game.id,
       :confirmable_type => "Game",
       :accept_code => accept_code,
       :reject_code => reject_code,
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
    accept_code = result.confirmations.to_accept.first.code
    reject_code = result.confirmations.to_reject.first.code
    {
      :notification_type_id => NotificationType.named("new_result").first.id,
      :params => {
        :title => "Result confirmation request",
        :message => "#{result.winner.name } claims that they won the game played against your team"+
                     "Do you want to <a href='/confirmations/#{accept_code}'>ACCEPT</a> or <a href='/confirmations/#{reject_code}'>REJECT</a> the offer?",
        :confirmable_id => result.id,
       :confirmable_type => "Result",
       :accept_code => accept_code,
       :reject_code => reject_code,
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
