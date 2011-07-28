
p1 = Player.create :name => "player_1", :email => "player_1@a.com"
p2 = Player.create :name => "player_2", :email => "player_2@a.com"

t = Team.create :name => 'team_1', :player1=> p1, :player2 => p2

