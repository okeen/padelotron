class Place < ActiveRecord::Base
  has_many :playgrounds

  geocoded_by :address
  after_create :create_playgrounds

  def address
    [street, city, state, country].compact.join(', ')
  end

  private

  def create_playgrounds
    playgrounds.create(:name => self.name, :sport => "padel")
  end
end
