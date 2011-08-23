class Playground < ActiveRecord::Base
  belongs_to :place
  has_many :games

  delegate :latitude, :to => :place
  delegate :longitude, :to => :place
  delegate :full_address, :to => :place

end
