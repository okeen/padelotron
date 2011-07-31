class Team < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :player1, :class_name => "Player"
  belongs_to :player2, :class_name => "Player"

  after_create :create_confirmations, :deliver_confirmation_ask_email

  has_many :confirmations, :as => :confirmable

  def confirm!
    update_attributes :status => 'confirmed'
  end

  def to_s
    "team #{self.name}"
  end
  private

  def create_confirmations
    ["accept", "reject"].each do |action_name|
      self.confirmations << Confirmation.new(:action => action_name, :code => rand(100000000000).to_s)
    end
  end

  def deliver_confirmation_ask_email
    TeamCreationMailer.team_membership_ask_mail(self).deliver
  end

  def deliver_confirmation_team_joined_or_rejected
    TeamCreationMailer.team_membership_ask_mail(self).deliver
  end
end
