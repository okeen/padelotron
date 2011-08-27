class Playground < ActiveRecord::Base
  belongs_to :place
  has_many :games
  has_many :playground_requests, :class_name => "Customer::PlaygroundRequest"
  delegate :latitude, :to => :place
  delegate :longitude, :to => :place
  delegate :full_address, :to => :place

  def as_json(options)
    super(:methods => [:latitude, :longitude])
  end
end
