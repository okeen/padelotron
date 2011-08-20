FactoryGirl.define do
    sequence :game_description do |n|
      "game description #{n}"
    end

  factory :friendly_game, :class => Game do
    association :team1, :factory => :team
    association :team2, :factory => :team
    play_date { DateTime.now }
    game_type "friendly"
    description  "mierda" #Factory.next(:game_description)
  end

  factory :confirmed_friendly_game, :class => Game do
    association :team1, :factory => :team
    association :team2, :factory => :team
    play_date { DateTime.now }
    game_type "friendly"
    description  "mierda" #Factory.next(:game_description)
    after_create {|game| game.confirm!}
  end


end