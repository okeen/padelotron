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

  def confirmation_mail(game)
    friendly_game_new_status(game, 'confirm')
  end

  def cancellation_mail(game)
    friendly_game_new_status(game,'cancel')
  end

  private

  def friendly_game_new_status(game, action)
    @game = game

    @starting_team = game.team1
    @rival_team = game.team2

#    puts "Game teams: #{game.teams.inspect}"
#    puts "Destiny team #{@email_destination_team.inspect}"
#    puts "Rival team #{@rival_team.inspect}"

    if (action == 'confirm')
      subject = "Friendly game confirmed"
    else
      subject = "Friendly game cancelled"
    end

    mail :to => @game.players.collect(&:email),
         :subject => subject

#  rescue
#    logger.error "Error sending game #{action} email for #{@email_destination_team.players.collect(&:email)}"
  end

end
