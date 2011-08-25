class Subscription < ActiveRecord::Base
  belongs_to :customer
  belongs_to :subscription_type
  scope :current, where(:active => true)

  def self.subscription_type_url(type)
    {
      :free => "https://tendel.chargify.com/h/48733/subscriptions/new"
    }[type]
  end

  def type
    subscription_type.name
  end
end
