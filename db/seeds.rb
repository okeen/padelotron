
p1 = FactoryGirl.create :player, :name => "Alicia Ciaila",
    :full_address => "Rua da Rosa 27, Santiago Compostela"
p2 = FactoryGirl.create :player, :name => "Roberto Otrebor",
    :full_address => "Plaza de Galicia , Santiago Compostela"
p3 = FactoryGirl.create :player, :name => "Carlos Loscar",
    :full_address => "Calle Dolores 2, Padron"
p4 = FactoryGirl.create :player, :name => "Diego Godie",
    :full_address => "Rua Quinteiro, Pontecesures"
p5 = FactoryGirl.create :player, :name => "Elena Anele",
    :full_address => "Rua Benito Corval 2, Pontevedra"
p6 = FactoryGirl.create :player, :name => "Fernando Donanfer",
    :full_address => "Rua das Estrigueiras, Pontevedra"

t1 = FactoryGirl.create :team , :player1 => p1, :player2 => p2,
                        :name => "Rio y no se por que"
t2 = FactoryGirl.create :team , :player1 => p3, :player2 => p4,
                        :name => "Peligrosa Maria"
t3 = FactoryGirl.create :team , :player1 => p5, :player2 => p6,
                        :name => "Viena el tren"

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


  p = Factory.create :place_with_customer,
              :name => "Fake Padel Club Santiago",
              :full_address => "Plaza de la Quintana, Santiago Compostela"

  p = Factory.create :place_with_customer,
              :name => "Padel Coremain",
              :full_address => "Rua de Amio, 128, Santiago Compostela"

  p = Factory.create :place_with_customer,
              :name => "Club Padel Tapadera",
              :full_address => "Rua Castro 4, Vilagarcia"


playgrounds = Place.all.collect(&:playgrounds).flatten


30.times do |i|
  first_team = rand(3) +1
  second_team = (first_team + (1 + rand(1))) % 3
  second_team = 1 if second_team == 0
  puts "#{first_team}/#{second_team}"
  ran=rand(365)
  g = FactoryGirl.create :friendly_game,
                         :team1_id => first_team,
                         :team2_id => second_team,
                         :playground => playgrounds[rand(playgrounds.count)],
                         :play_date => DateTime.now + ran.days
  g.confirm!
  puts "Created Friendly confirmed game: #{g.reload.inspect}"
end

100.times do |i|
  first_team = rand(3) +1
  second_team = (first_team + (1 + rand(1))) % 3
  second_team = 1 if second_team == 0
  puts "#{first_team}/#{second_team}"
  ran=rand(365)
  g = FactoryGirl.create :friendly_game, 
                         :team1_id => first_team,
                         :team2_id => second_team,
                         :playground => playgrounds[rand(playgrounds.count)],
                         :play_date => DateTime.now - ran.days
  g.confirm!
  puts "Created past Friendly confirmed game: #{g.reload.inspect}"

  result = g.create_result  \
               :result_sets =>
               {'0' => create_a_winner_set_for_team1,
                '1' => create_a_winner_set_for_team2,
                '2' => rand(1) == 0 ? create_a_winner_set_for_team1 :
                                      create_a_winner_set_for_team2
               }
     result.confirm!
end
