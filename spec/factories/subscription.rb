FactoryGirl.define do


  factory :free_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type_id {SubscriptionType.named("free").first.id}
  end

  factory :premium_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type_id {SubscriptionType.named("premium").first.id}
  end


  factory :platinum_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type_id {SubscriptionType.named("platinum").first.id}
  end
end