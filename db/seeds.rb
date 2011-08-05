
p1 = FactoryGirl.create :player
p2 = FactoryGirl.create :player
p3 = FactoryGirl.create :player
p4 = FactoryGirl.create :player
p5 = FactoryGirl.create :player
p6 = FactoryGirl.create :player

t1 = FactoryGirl.create :team , :player1 => p1, :player2 => p2
t2 = FactoryGirl.create :team , :player1 => p3, :player2 => p4
t3 = FactoryGirl.create :team , :player1 => p5, :player2 => p6
t4 = FactoryGirl.create :team , :player1 => p1, :player2 => p3

t1.confirm!
t2.confirm!
t3.confirm!

Player.all.each { |player| puts "Created player: #{player.reload.inspect}}"}
Team.all.each { |team| puts "Created team: #{team.reload.inspect}"}

g1 = FactoryGirl.create :friendly_game, :team1 => t1, :team2 => t2,
                        :description => 'unconfirmed game'
puts "Created unconfirmed Friendly game: #{g1.reload.inspect}"

g2 = FactoryGirl.create :friendly_game, :team1 => t2, :team2 => t3
g2.confirm!
puts "Created Friendly confirmed game: #{g2.reload.inspect}"
