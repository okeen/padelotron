module SubscriptionsHelper
  def link_to_subscription_for_customer(customer, subscription_type)
    customer_params = {
      :reference => customer.id,
      :first_name => customer.name,
      :last_name => customer.surname,
      :email => customer.email
    }
    params= customer_params.keys.collect{|attr| "#{attr}=#{customer_params[attr]}"}.join("&")
    if (subscription_type == :free)
      link_to "Free",Subscription.subscription_type_url(:free)+"?#{params}", :class => "product"
    end
  end
end
