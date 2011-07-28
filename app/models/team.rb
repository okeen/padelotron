class Team < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => true
  
  belongs_to :player1, :class_name => "Player"
  belongs_to :player2, :class_name => "Player"

  after_create :create_confirmations

  has_many :confirmations, :as => :confirmable

  private

  def create_confirmations
    ["accept", "reject"].each do |action_name|
      self.confirmations << Confirmation.new(:action => action_name, :code => rand(100000000000).to_s)
    end
    

  end
end
