class Playground < ActiveRecord::Base
  belongs_to :place
  has_many :games
  has_many :playground_requests, :class_name => "Customer::PlaygroundRequest"
  delegate :geocoded?, :to => :place
  delegate :latitude, :to => :place
  delegate :longitude, :to => :place
  delegate :area_level1, :to => :place
  delegate :area_level2, :to => :place
  delegate :city, :to => :place
  delegate :street, :to => :place
  delegate :full_address, :to => :place
  delegate :customer, :to => :place

  geocoded_by :full_address

  def reservation_required?
    return false if self.place.customer.blank?
    self.place.customer.is_premium? or self.place.customer.is_platinum?
  end

  def to_s
    place.name
  end

  def as_json(options)
    super(:methods => [:latitude, :longitude])
  end
end
