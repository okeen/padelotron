class Customers::PlaygroundRequestsController < ApplicationController
  before_filter :authenticate_customer!
  # GET /customer/playground_requests
  # GET /customer/playground_requests.xml
  
  def update
    @game = Game.send(:with_exclusive_scope) {
      Game.includes(:team1,:team2).find(params[:id])
      }
    @customer_playground_request = @game.playground_request

    respond_to do |format|
      if @customer_playground_request.update_attributes(params[:customer_playground_request])
        message="Playground reservation #{@customer_playground_request.status} ok"
        format.html { redirect_to(@customer_playground_request, :notice => 'Playground request was successfully updated.') }
        format.json { render :json => {:message => "message", :model => @customer_playground_request }}
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @customer_playground_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @customer_playground_request = Customer::PlaygroundRequest.by_code(params[:code]).first
  end

  # DELETE /customer/playground_requests/1
  # DELETE /customer/playground_requests/1.xml
  def destroy
    @customer_playground_request = Customer::PlaygroundRequest.find(params[:id])
    @customer_playground_request.destroy

    respond_to do |format|
      format.html { redirect_to(customer_playground_requests_url) }
      format.xml  { head :ok }
    end
  end
end
