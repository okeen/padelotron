class SubscriptionType < ActiveRecord::Base
  has_many :subscriptions

  scope :named, lambda {|name| where('name = ?', name)}
  scope :with_external_id, lambda {|external_id| where('external_id= ?', external_id)}

  def self.create_all_achievement_types
    SubscriptionType.create(:name => "free",
                            :external_id => 48733,
                            :external_url => "https://tendel.chargify.com/h/48733/subscriptions/new")
    SubscriptionType.create(:name => "premium",
                            :external_id => 48734,
                            :external_url => "https://tendel.chargify.com/h/48734/subscriptions/new")
  end

  if self.all.blank?
    self.create_all_achievement_types
  end
end
