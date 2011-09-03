class Team < ActiveRecord::Base

  belongs_to :player1, :class_name => "Player"
  belongs_to :player2, :class_name => "Player"

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :name, :presence => true, :uniqueness => true
  validates_associated :player1
  validates_associated :player2

  include Statable
  include Confirmable

  has_many :games, :finder_sql => 'select * from games g where g.team1_id = #{id} or g.team2_id = #{id}'

  scope :available_for_today, lambda {
    where('not id in (?)',Game.for_today.collect(&:teams).flatten.collect(&:id) )
  }

  scope :by_letter, lambda{ |letter|
    where("lower(name) like ?", "#{letter.downcase}%")
  }
  def image_path
    image.url
  end
  def players
    [player1,player2]
  end
  
  def to_s
    "team #{self.name}"
  end

  def as_json(options = {})
    super(:only => [:name, :id],
          :methods => [:image_path],
          :include => {
             :player1 => {:only => [:name, :id, :facebook_id]},
             :player2 => {:only => [:name, :id, :facebook_id]},
             :confirmations => {:only => [:code, :action]   }})
  end
  #TODO: refactorizar esto para no crear estos cuatro métodos por cada confirmable
  def confirmation_message
    "joined #{self.name}"
  end

  def on_confirm

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
