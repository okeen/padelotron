class Result < ActiveRecord::Base

  belongs_to :game

  delegate :team1, :to => :game
  delegate :team2, :to => :game

  include Confirmable

  serialize :result_sets
  GameSet = Struct.new :number, :team1_score, :team2_score

  def sets
    result_sets.keys.collect do |set_number|
      scores = result_sets[set_number]
      GameSet.new(set_number, scores[:team1], scores[:team2])
    end
  end
  
  #messages to show in confirmations
  def confirmation_message
    "confirmed the result of the game #{game.description}"
  end

  def rejection_message
    "rejected the result of the game #{game.description}"
  end
  #messages to show in confirmations
  def confirmation_ask_message
    "confirm the result of the game #{game.description}"
  end

  def rejection_ask_message
    "reject the result of the game #{game.description}"
  end

  private

  def confirmating_player_groups
    game.teams
  end

end
