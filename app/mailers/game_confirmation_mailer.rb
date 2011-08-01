class GameConfirmationMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.game_confirmation_mailer.friendly_game_confirmation_email.subject
  #
  def friendly_game_confirmation_email
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
