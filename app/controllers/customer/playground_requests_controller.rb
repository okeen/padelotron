class Customer::PlaygroundRequestsController < ApplicationController
  # GET /customer/playground_requests
  # GET /customer/playground_requests.xml
  def index
    @customer_playground_requests = Customer::PlaygroundRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customer_playground_requests }
    end
  end

  # GET /customer/playground_requests/1
  # GET /customer/playground_requests/1.xml
  def show
    @customer_playground_request = Customer::PlaygroundRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer_playground_request }
    end
  end

  # GET /customer/playground_requests/new
  # GET /customer/playground_requests/new.xml
  def new
    @customer_playground_request = Customer::PlaygroundRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer_playground_request }
    end
  end

  # GET /customer/playground_requests/1/edit
  def edit
    @customer_playground_request = Customer::PlaygroundRequest.find(params[:id])
  end

  # POST /customer/playground_requests
  # POST /customer/playground_requests.xml
  def create
    @customer_playground_request = Customer::PlaygroundRequest.new(params[:customer_playground_request])

    respond_to do |format|
      if @customer_playground_request.save
        format.html { redirect_to(@customer_playground_request, :notice => 'Playground request was successfully created.') }
        format.xml  { render :xml => @customer_playground_request, :status => :created, :location => @customer_playground_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer_playground_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customer/playground_requests/1
  # PUT /customer/playground_requests/1.xml
  def update
    @customer_playground_request = Customer::PlaygroundRequest.find(params[:id])

    respond_to do |format|
      if @customer_playground_request.update_attributes(params[:customer_playground_request])
        format.html { redirect_to(@customer_playground_request, :notice => 'Playground request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer_playground_request.errors, :status => :unprocessable_entity }
      end
    end
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
