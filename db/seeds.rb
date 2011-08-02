
p1 = Player.create :name => "player_1", :email => "player_1@a.com"
p2 = Player.create :name => "player_2", :email => "player_2@a.com"
p3 = Player.create :name => "player_3", :email => "player_3@a.com"
p4 = Player.create :name => "player_4", :email => "player_4@a.com"

t1 = Team.create :name => 'team_1', :player1=> p1, :player2 => p2
t1.confirm!
t2 = Team.create :name => 'team_2', :player1=> p3, :player2 => p4
t2.confirm!
t2 = Team.create :name => 'team_3', :player1=> p1, :player2 => p4




