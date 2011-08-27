FactoryGirl.define do
    sequence :customer_name do |n|
      "customer #{n}"
    end
    sequence :customer_surname do |n|
      "surname #{n}"
    end
    sequence :customer_email do |n|
      "customer#{n}@a.com"
    end

  factory :customer, :class => Customer do
    name {Factory.next :customer_name}
    surname {Factory.next :customer_surname}
    email {Factory.next :customer_email}
    password "aaaaaa"
    password_confirmation "aaaaaa"
  end

  factory :confirmed_customer, :class => Customer do
    name {Factory.next :customer_name}
    surname {Factory.next :customer_surname}
    email {Factory.next :customer_email}
    password "aaaaaa"
    password_confirmation "aaaaaa"
    after_create {|customer| customer.confirm!}
  end


  factory :customer_with_premium_subscription, :class => Customer do
    name {Factory.next :customer_name}
    surname {Factory.next :customer_surname}
    email {Factory.next :customer_email}
    password "aaaaaa"
    password_confirmation "aaaaaa"
    after_create {|customer|
      customer.confirm!
      customer.subscriptions.create(Factory.build :premium_subscription)
    }
  end


end