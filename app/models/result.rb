class Result < ActiveRecord::Base

  belongs_to :game

  delegate :team1, :to => :game
  delegate :team2, :to => :game
  delegate :winner, :to => :game

  include Confirmable

  serialize :result_sets
  GameSet = Struct.new :number, :team1_score, :team2_score

  def sets
    result_sets.keys.collect do |set_number|
      scores = result_sets[set_number]
      GameSet.new(set_number, scores[:team1], scores[:team2])
    end
  end
  
  def winner
    scores = {:team1=> 0, :team2 => 0}
    sets.each do |set| 
      if set.team1_score > set.team2_score
        scores[:team1]+=1
      else
        scores[:team2]+=1
      end
    end
    return scores[:team1] > scores[:team2] ? game.team1 : game.team2
  end

  def on_confirm
    game.update_attribute :winner_team_id, winner.id
    Stat.update_all_for_game(game)
  end

  def as_json(options={})
    super(:include => {
              :game => {
                 :include => {
                    :team1 => {:methods => [:players]},
                    :team2 => {:methods => [:players]}
                  }
               }
           },
         :methods => [:winner])
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
    game.winner == team1 ? team2 : team1
  end

end
