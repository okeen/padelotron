class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :confirmable, :recoverable, :rememberable, :trackable
  
end
