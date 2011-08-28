class Playground < ActiveRecord::Base
  belongs_to :place
  has_many :games
  has_many :playground_requests, :class_name => "Customer::PlaygroundRequest"
  delegate :latitude, :to => :place
  delegate :longitude, :to => :place
  delegate :full_address, :to => :place
  delegate :customer, :to => :place

  def reservation_required?
    return false if self.place.customer.blank?
    self.place.customer.is_premium? or self.place.customer.is_platinum?
  end

  def as_json(options)
    super(:methods => [:latitude, :longitude])
  end
end
