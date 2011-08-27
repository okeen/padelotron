class PlaygroundRequestMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.playground_request.ask_mail.subject
  #
  def ask_mail(customer, game)
    @customer = customer
    mail :to => customer.email, :subject => "Game request for playground #{game.playground.name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.playground_request.confirmation_mail.subject
  #
  def confirmation_mail(game)
    
    @game = game
    mail :to => game.players.collect(&:email),:subject => "Playground reserve confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.playground_request.cancellation_mail.subject
  #
  def cancellation_mail(game)
    @game = game
    mail :to => game.players.collect(&:email),:subject => "Playground reserve rejection"
  end
end
