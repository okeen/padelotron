class Customer::PlaygroundRequest < ActiveRecord::Base
  belongs_to :game
  belongs_to :playground
end
