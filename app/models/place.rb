class Place < ActiveRecord::Base
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode

  has_many :playgrounds
end
