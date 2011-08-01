class GameConfirmationMailer < ActionMailer::Base
  default :from => "mailer@padelotron.heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.game_confirmation_mailer.friendly_game_confirmation_email.subject
  #
  def friendly_game_confirmation_email(game)
    @game = game

    mail :to => game.team2.players.collect(&:email),
         :subject => "Friendly game offer from #{@game.team1.name} received"
  end
end
