class Game < ActiveRecord::Base

  belongs_to :team1, :class_name => "Team"
  belongs_to :team2, :class_name => "Team"

  has_one :result
  #after_create :create_result
  
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

  private

  def confirmating_player_groups
    teams
  end

end
