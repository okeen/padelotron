FactoryGirl.define do

sequence :place_name do |n|
      "place #{n}"
    end
    sequence :place_country do |n|
      "Spain"
    end
    sequence :place_city do |n|
      ["Santiago Compostela", "Vilagarcia de Arousa", "Pontevedra"][rand(3)+1]
    end

    sequence :place_street do |n|
      ""
    end

  factory :place, :class => Place do
    name {Factory.next :place_name}
    country {Factory.next :place_country}
    city {Factory.next :place_city}
    street {Factory.next :place_street}
    latitude {42.88256 + (rand) - 0.5}
    longitude {(-8.535357) + (rand) - 0.5}
    full_address {"#{street}, #{city}, #{country}"}
  end

  factory :place_with_customer, :class => Place do
    name {Factory.next :place_name}
    country {Factory.next :place_country}
    city {Factory.next :place_city}
    street {Factory.next :place_street}
    latitude {42.88256 + (rand) - 0.5}
    longitude {(-8.535357) + (rand) - 0.5}
    full_address {"#{street}, #{city}, #{country}"}
    association :customer, :factory => :confirmed_customer
  end
end