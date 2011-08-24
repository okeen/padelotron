class Customers::ConfirmationsController < Devise::ConfirmationsController

  after_filter :redirect_to_customer, :only => 'show'
  protected

  def after_confirmation_path_for(name, resource)
    customer_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    '/an/example/path'
  end
  
end