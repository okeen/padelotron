class Team < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :player1, :class_name => "Player"
  belongs_to :player2, :class_name => "Player"

  default_scope where(:status => "confirmed")

  after_create :create_confirmations, :deliver_confirmation_ask_email
  

  has_many :confirmations, :as => :confirmable
  has_many :games, :finder_sql => 'select * from games g where g.team1_id == #{id} or g.team2_id == #{id}'

  def players
    [player1,player2]
  end
  
  def confirm!
    update_attributes :status => 'confirmed'
    deliver_team_joined_confirmation_email
  end

  def reject!
    update_attributes :status => 'rejected'
    deliver_team_cancellation_email
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

  def create_confirmations
    ["accept", "reject"].each do |action_name|
      self.confirmations << Confirmation.new(:action => action_name, :code => rand(100000000000).to_s)
    end
    set_initial_status
  end

  def set_initial_status
    update_attributes :status => 'new'
  end

  def deliver_confirmation_ask_email
    TeamCreationMailer.team_membership_ask_mail(self).deliver
  end

  def deliver_team_joined_confirmation_email
    TeamCreationMailer.team_membership_confirmation(self).deliver
  end

  def deliver_team_cancellation_email
    TeamCreationMailer.team_membership_cancellation(self).deliver
  end
end
