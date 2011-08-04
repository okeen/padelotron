class Team < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :player1, :class_name => "Player"
  belongs_to :player2, :class_name => "Player"

  include Confirmable

  has_many :games, :finder_sql => 'select * from games g where g.team1_id == #{id} or g.team2_id == #{id}'

  scope :available_for_today, lambda {
    joins(:games).where(':play_date > ?', Date.today.end_of_day)
  }

  
  def players
    [player1,player2]
  end
  
  def to_s
    "team #{self.name}"
  end

  #TODO: refactorizar esto para no crear estos cuatro métodos por cada confirmable
  def confirmation_message
    "joined #{self.name}"
  end

  def rejection_message
    "rejected joining #{self.name}"
  end

  def confirmation_ask_message
    "join #{self.name}?"
  end

  def rejection_ask_message
    "reject joining #{self.name}"
  end

  private

  def confirmating_player_groups
    [self]
  end
end
