class Customers::GraphicController < ApplicationController
  helper :customers
  layout 'customers'
  before_filter :authenticate_customer!, :load_customer
  
  def show
     respond_to do |format|
      format.html
    end
  end

  private

  def load_customer
    @customer = current_customer
  end
end