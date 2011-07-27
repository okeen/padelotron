class Team < ActiveRecord::Base

  belongs_to :player1, :class_name => "Player", :column=> 'player1_id'
  belongs_to :player2, :class_name => "Player", :column => 'player2_id'

  
end
