
p1 = FactoryGirl.create :player
p2 = FactoryGirl.create :player
p3 = FactoryGirl.create :player
p4 = FactoryGirl.create :player
p5 = FactoryGirl.create :player
p6 = FactoryGirl.create :player

t1 = FactoryGirl.create :team , :player1 => p1, :player2 => p2
t2 = FactoryGirl.create :team , :player1 => p3, :player2 => p4
t3 = FactoryGirl.create :team , :player1 => p5, :player2 => p6

t1.confirm!
t2.confirm!
t3.confirm!

Player.all.each { |player| puts "Created player: #{player.reload.inspect}}"}
Team.all.each { |team| puts "Created team: #{team.reload.inspect}"}

def create_a_winner_set_for_team1
    {:team1 => 6, :team2 => rand(5)}
end

def create_a_winner_set_for_team2
    {:team2 => 6, :team1 => rand(5)}
end


10.times do |t|
  Factory.create :place_with_customer
end

playgrounds = Place.all.collect(&:playgrounds).flatten

100.times do |i|
  first_team = rand(3) +1
  second_team = (first_team + (1 + rand(1))) % 3
  second_team = 1 if second_team == 0
  puts "#{first_team}/#{second_team}"
  g = FactoryGirl.create :friendly_game, 
                         :team1_id => first_team,
                         :team2_id => second_team,
                         :playground => playgrounds[rand(playgrounds.count)]
  g.confirm!
  puts "Created Friendly confirmed game: #{g.reload.inspect}"

  result = g.create_result  \
               :result_sets =>
               {'0' => create_a_winner_set_for_team1,
                '1' => create_a_winner_set_for_team2,
                '2' => rand(1) == 0 ? create_a_winner_set_for_team1 :
                                      create_a_winner_set_for_team2
               }
     result.confirm!

end
g1 = FactoryGirl.create :friendly_game, :team1 => t1, :team2 => t2,
  :description => 'unconfirmed game'
puts "Created unconfirmed Friendly game: #{g1.reload.inspect}"

g2 = FactoryGirl.create :friendly_game, :team1 => t2, :team2 => t3
g2.confirm!
puts "Created Friendly confirmed game: #{g2.reload.inspect}"
