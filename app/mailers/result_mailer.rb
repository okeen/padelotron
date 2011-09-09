class ResultMailer < ActionMailer::Base
  default :from => "mailer@padelotron.heroku.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.result_confirmation_mailer.friendly_result_confirmation_email.subject
  #
  def ask_mail(result)
    @result = result

    mail :to => result.team2.players.collect(&:email),
      :subject => "Game result offer for game #{@result.game.description} received"
  rescue
    #    logger.error "Error sending result #{action} email for #{@email_destination_team.players.collect(&:email)}"
  end

  def confirmation_mail(result)
    friendly_result_new_status(result, 'confirm')
  end

  def cancellation_mail(result)
    friendly_result_new_status(result,'cancel')
  end

  private

  def friendly_result_new_status(result, action)
    @result = result
    @rival_team = result.game.team2

    if (action == 'confirm')
      subject = "Game result for game #{@result.game.description} confirmed"
    else
      subject = "Game result for game #{@result.game.description} cancelled"
    end

    mail :to => @result.players.collect(&:email),
      :subject => subject

  rescue
    #    logger.error "Error sending result #{action} email for #{@email_destination_team.players.collect(&:email)}"
  end

end
