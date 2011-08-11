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
  end

  def confirmation_mail(result, email_destination_team)
    friendly_result_new_status(result, email_destination_team, 'confirm')
  end

  def cancellation_mail(result, email_destination_team)
    friendly_result_new_status(result, email_destination_team,'cancel')
  end

  private

  def friendly_result_new_status(result, email_destination_team, action)
    @result = result
    @email_destination_team = email_destination_team
    @rival_team = result.teams.reject {|team| team == email_destination_team}.first

#    puts "result teams: #{result.teams.inspect}"
#    puts "Destiny team #{@email_destination_team.inspect}"
#    puts "Rival team #{@rival_team.inspect}"

    if (action == 'confirm')
      subject = "Friendly result against #{@rival_team.name} confirmed"
      @message = "You confirmed a friendly result against #{@rival_team.name}"
    else
      subject = "Friendly result against #{@rival_team.name} cancelled"
      @message = "You cancelled a friendly result against #{@rival_team.name}"
    end

    mail :to => email_destination_team.players.collect(&:email),
         :subject => subject

  rescue
    logger.error "Error sending result #{action} email for #{@email_destination_team.players.collect(&:email)}"
  end

end
