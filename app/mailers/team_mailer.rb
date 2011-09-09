class TeamMailer < ActionMailer::Base
  default :from => "<Padelotron>mailer@padelotron.heroku.com"
  
  def ask_mail(team)
    @team = team
    
    mail :to => @team.player2.email,
      :subject => "Padelotron. #{@team.player1.name} wants you to join a team"
  rescue => e
   # logger.error "Error sending membership email for #{@team.players.collect(&:email)}"
  logger.warn "Error sending team membership email: #{e.inspect}"
  end

  def confirmation_mail(team, not_used)
    team_membership_new_status(team, 'confirm')
  end

  def cancellation_mail(team, not_used)
    team_membership_new_status(team, 'cancel')
  end

  private

  def team_membership_new_status(team, action)
    @team = team
    if (action == 'confirm')
      subject = "Padelotron. You joined #{@team.name}"
      @message = "You just joined the team #{@team.name}"
    else
      subject = "Padelotron. You rejected joining #{@team.name}"
      @message = "You just rejected joining the team #{@team.name}"
    end
    mail :to => @team.players.collect(&:email), :subject => subject
  rescue => e
    logger.warn "Error sending team confirmation email: #{e.inspect}"
  end

end
