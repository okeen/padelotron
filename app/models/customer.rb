class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :confirmable, :recoverable, :rememberable, :trackable

  has_many :places
  has_many :subscriptions 

  accepts_nested_attributes_for :places, :allow_destroy => true

end
