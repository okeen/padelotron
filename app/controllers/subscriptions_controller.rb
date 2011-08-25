class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.xml
  before_filter :load_owner_customer,:login_as_owner_required, :except => :create
  before_filter :authenticate_customer!, :only => :create
  layout "customers"
  
  def index
    @subscriptions = Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.xml
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    @customer = Customer.find(params[:customer_reference])
    @subscription = @customer.subscriptions.build(
      :subscription_type => SubscriptionType.with_external_id(params[:product_id]).first,
      :external_signup_payment_id => params[:subscription_id],
      :external_id => params[:subscription_id]
    )
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to(@customer, :notice => "Subscription #{@subscription.type} was successfully created.") }
        format.xml  { render :xml => @subscription, :status => :created, :location => @subscription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to(@subscription, :notice => 'Subscription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.xml
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to(subscriptions_url) }
      format.xml  { head :ok }
    end
  end



  private

  def login_as_owner_required
    authenticate_customer!
    unless current_customer.id == params[:customer_id].to_i
      flash[:notice] = "Unauthorized"
      redirect_to customers_path
      return false
    end
  end

  def load_owner_customer
    @customer = Customer.find(params[:customer_id])
  end
end
