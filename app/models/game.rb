class Game < ActiveRecord::Base

  belongs_to :team1, :class_name => "Team"
  belongs_to :team2, :class_name => "Team"
  belongs_to :winner_team, :class_name => "Team"

  has_one :result
  #after_create :create_result

  delegate :sets, :to => :result
  
  include Confirmable

  def teams
    [team1,team2]
  end

  def players
    teams.collect(&:players).flatten
  end

  #aplicamos operador lambda para q evalúe la condición justo al ejecutarlo
  scope :for_date, lambda { |date|
    where("play_date >= :start_date AND play_date <= :end_date",{
        :start_date => date.beginning_of_day,
        :end_date => date.end_of_day }
    ).order(:play_date)
  }
  scope :for_today, lambda {
    for_date(Date.today)
  }
    
  def is_friendly?
    game_type == "friendly"
  end

  #messages to show in confirmations
  def confirmation_message
    "confirmed a game against #{self.team1.name}"
  end

  def rejection_message
    "rejected playing a game against #{self.team1.name}"
  end
  #messages to show in confirmations
  def confirmation_ask_message
    "confirm the friendly game against #{self.team1.name}"
  end

  def rejection_ask_message
    "reject the friendly game against #{self.team1.name}"
  end

  def needs_confirmation?
    is_friendly?
    true
  end

  def confirm_facebook_event_attendance(current_player, facebook_access_token)
    require 'koala'
    graph = Koala::Facebook::GraphAndRestAPI.new(facebook_access_token)
    graph.rest_call("events.rsvp", {
        :eid =>self.facebook_event_id,
        :rsvp_status =>  "attending"
      })
  end

  def create_facebook_game_event(initiator_player,facebook_token)
    require 'koala'
    graph = Koala::Facebook::GraphAndRestAPI.new(facebook_token)
    #picture = Koala::UploadableIO.new(File.open("PATH TO YOUR EVENT IMAGE"))
    params = {
      #:picture => picture,
      :name => "Padel Game: #{team1.name} VS #{team2.name}",
      :description => "Padel game between teams #{team1.name}(#{team1.player1.name}, #{team1.player2.name})"\
        + " and #{team2.name}(#{team2.player1.name}, #{team2.player2.name})",
      :owner => initiator_player.facebook_id,
      :location => "A mina casa",
      :street => "Rua da Rosa 27",
      :city => "Santiago Compostela",
      :start_time => self.play_date,
      :end_time => self.play_date + 1.hour
    }
    #invite the other players
    event = graph.put_object('me', 'events', params )
    update_attribute(:facebook_event_id, event['id'])
    logger.debug "Event: #{event}"
    graph.rest_call("events.invite", {
        :eid => event['id'],
        :uids =>  ((players) -[initiator_player]).collect(&:facebook_id).join(","),
        :personal_message => "You have a padel game to play"
      })
  end

  private

  def confirmating_player_groups
    teams
  end

end
