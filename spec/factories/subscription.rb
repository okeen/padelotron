FactoryGirl.define do


  factory :free_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type {SubscriptionType.named("free").first}
  end

  factory :premium_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type {SubscriptionType.named("premium").first}
  end


  factory :platinum_subscription, :class => Subscription do
    payment_to_date  true
    active  true
    last_payment { DateTime.now}
    subscription_type {SubscriptionType.named("platinum").first}
  end
end