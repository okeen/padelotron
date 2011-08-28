class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :confirmable, :recoverable, :rememberable, :trackable, :validatable

  has_many :places
  has_many :subscriptions 


  accepts_nested_attributes_for :places, :allow_destroy => true

def is_premium?
  subscriptions.current.last and subscriptions.current.last.name == "premium"
end

def is_platinum?
  subscriptions.current.last and subscriptions.current.last.name == "platinum"
end

end
