class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.xml
  before_filter :login_as_owner_required, :except => [:index, :create, :new]
  
  def index
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html {
        if (@customer.subscriptions.current.blank?)
          redirect_to new_customer_subscription_path(@customer)
        else
          render 'show'
        end
        }
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new
    @customer.places.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        message = "Your info has been received. We just sent you an email with the confirmation code to activate the account"
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.js { render :json =>{:message => message, :model => @customer}.to_json, :status => :created}
      else
        format.html { render :action => "new" }
        format.js  { render :json=> @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to(@customer, :notice => 'Customer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def after_sign_up_path_for(resource)
    customer_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def login_as_owner_required
    authenticate_customer!
    unless current_customer.id == params[:id].to_i
      flash[:notice] = "Unauthorized"
      redirect_to customers_path
      return false
    end
  end
end
