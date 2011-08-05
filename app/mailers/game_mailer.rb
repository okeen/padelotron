class GameMailer < ActionMailer::Base
  default :from => "mailer@padelotron.heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.game_confirmation_mailer.friendly_game_confirmation_email.subject
  #
  def ask_mail(game)
    @game = game

    mail :to => game.team2.players.collect(&:email),
         :subject => "Friendly game offer from #{@game.team1.name} received"
  end

  def confirmation_mail(game, email_destination_team)
    friendly_game_new_status(game, email_destination_team, 'confirm')
  end

  def cancellation_mail(game, email_destination_team)
    friendly_game_new_status(game, email_destination_team,'cancel')
  end

  private

  def friendly_game_new_status(game, email_destination_team, action)
    @game = game
    @email_destination_team = email_destination_team
    @rival_team = game.teams.reject {|team| team == email_destination_team}.first

#    puts "Game teams: #{game.teams.inspect}"
#    puts "Destiny team #{@email_destination_team.inspect}"
#    puts "Rival team #{@rival_team.inspect}"

    if (action == 'confirm')
      subject = "Friendly game against #{@rival_team.name} confirmed"
      @message = "You confirmed a friendly game against #{@rival_team.name}"
    else
      subject = "Friendly game against #{@rival_team.name} cancelled"
      @message = "You cancelled a friendly game against #{@rival_team.name}"
    end

    mail :to => email_destination_team.players.collect(&:email),
         :subject => subject

  rescue
    logger.error "Error sending game #{action} email for #{@email_destination_team.players.collect(&:email)}"
  end

end
