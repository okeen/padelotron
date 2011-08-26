class Place < ActiveRecord::Base
  has_many :playgrounds
  has_many :games, :through => :playgrounds
  
  geocoded_by :address
  after_create :create_playgrounds

  belongs_to :customer

  default_scope includes(:playgrounds)
  
  def address
    [street, city, state, country].compact.join(', ')
  end

  private

  def create_playgrounds
    playgrounds.create(:name => self.name, :sport => "padel")
  end
end
