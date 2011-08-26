class Customers::AgendasController < ApplicationController
  helper :customers
  layout 'customers'
  
  def show
    @customer = current_customer
    respond_to do |format|
      format.html 
    end
  end
end
