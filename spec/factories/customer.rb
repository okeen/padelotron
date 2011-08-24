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
    #email_confirmation { email }
  end

  factory :confirmed_customer, :class => Customer do
    name {Factory.next :customer_name}
    surname {Factory.next :customer_surname}
    email {Factory.next :customer_email}
    #email_confirmation { email }
    after_create {|customer| customer.confirm!}
  end


end