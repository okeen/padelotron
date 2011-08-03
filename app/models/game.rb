class Game < ActiveRecord::Base

  belongs_to :team1, :class_name => "Team"
  belongs_to :team2, :class_name => "Team"

  after_create :create_confirmations_if_friendly_game, :deliver_game_confirmation_ask_email
  
  has_many :confirmations, :as => :confirmable

  def teams
    [team1,team2]
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
  
  
  def confirm!
    update_attributes :status => 'confirmed'
    deliver_game_confirmation_email
  end

  def reject!
    update_attributes :status => 'rejected'
    deliver_game_cancellation_email
  end

  def self.create_friendly(team1,team2,play_date)
    Game.create(:team1 => team1,:team2 => team2, :play_date => play_date, :game_type => 'friendly')
  end

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

  private

  def create_confirmations_if_friendly_game
    if self.is_friendly?
      ["accept", "reject"].each do |action_name|
        self.confirmations << Confirmation.new(:action => action_name, :code => rand(100000000000).to_s)
      end
    end
  end

  def deliver_game_confirmation_ask_email
      GameConfirmationMailer.friendly_game_confirmation_ask(self).deliver
  end

  def deliver_game_confirmation_email
    self.teams.each do |team|
      GameConfirmationMailer.friendly_game_confirmation(self, team).deliver
    end
  end

  def deliver_game_cancellation_email
    self.teams.each do |team|
      GameConfirmationMailer.friendly_game_cancellation(self, team).deliver
    end
  end
end
