FactoryGirl.define do
    sequence :team_name do |n|
      "team#{n}"
    end

  factory :team  do
    name  {Factory.next(:team_name)}
    association :player1, :factory => :player
    association :player2, :factory => :player
  end

  factory :confirmed_team , :class => Team do
    name  {Factory.next(:team_name)}
    association :player1, :factory => :player
    association :player2, :factory => :player
    after_create {|team| team.confirm!}
  end

end