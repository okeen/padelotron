FactoryGirl.define do
    sequence :player_name do |n|
      "player#{n}"
    end

    sequence :email do |n|
      "player#{n}@a.com"
    end

  factory :player do
    name {Factory.next(:player_name)}
    email
  end

end