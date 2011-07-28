class TeamCreationMailer < ActionMailer::Base
  default :from => "mailer@padelotron.heroku.com"
  
  def team_membership_ask_mail(team)
    @team = team
    
    mail :to => @team.player2.email,
      :subject => "Padelotron. #{@team.player1.name} wants you to join a team"
  end

end
