class SubscriptionType < ActiveRecord::Base
  has_many :subscriptions


  scope :named, lambda {|name| where('name = ?', name)}
  scope :with_external_id, lambda {|external_id| where('external_id= ?', external_id)}

  def self.create_all_achievement_types
    SubscriptionType.create(:name => "free",
                            :external_id => 48876,
                            :external_url => "https://tendel.chargify.com/h/48876/subscriptions/new")
    SubscriptionType.create(:name => "premium",
                            :external_id => 48882,
                            :external_url => "https://tendel.chargify.com/h/48882/subscriptions/new")
    SubscriptionType.create(:name => "platinum",
                            :external_id => 48910,
                            :external_url => "https://tendel.chargify.com/h/48910/subscriptions/new")
  end

  if self.all.blank?
    self.create_all_achievement_types
  end
end
