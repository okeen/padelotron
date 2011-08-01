class Game < ActiveRecord::Base

  belongs_to :team1, :class_name => "Team"
  belongs_to :team2, :class_name => "Team"

  def create_friendly(team1,team2,play_date)
    Game.create(:team1 => team1,:team2 => team2, :play_date => play_date, :game_type => 'friendly')
  end
end
