FactoryGirl.define do
    sequence :playground_name do |n|
      "playground #{n}"
    end

  factory :playground do
    association :place, :factory => :place
    name {Factory.next :playground_name}
    sport "padel"
    reservation_required false
  end
end