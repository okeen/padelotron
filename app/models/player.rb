class Player < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  validates :email, :presence => true,  :uniqueness => true

  has_many :teams
end
