module SubscriptionsHelper
  def link_to_subscription_for_customer(customer, subscription_type)
    customer_params = {
      :reference => customer.id.to_s,
      :first_name => customer.name,
      :last_name => customer.surname,
      :email => customer.email
    }
    params= customer_params.keys.collect{|attr| "#{attr}=#{CGI.escape(customer_params[attr])}"}.join("&")
    if (subscription_type == :free)
      return link_to "free",SubscriptionType.named("free").first.external_url+"?#{params}",
              :class => "product"
    end
    if (subscription_type == :premium)
      return link_to "premium",SubscriptionType.named("premium").first.external_url+"?#{params}",
              :class => "product"
    end
    if (subscription_type == :platinum)
      return link_to "platinum",SubscriptionType.named("platinum").first.external_url+"?#{params}",
              :class => "product"
    end
  end
end
