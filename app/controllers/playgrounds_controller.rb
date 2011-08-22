class PlaygroundsController < ApplicationController
  # GET /playgrounds
  # GET /playgrounds.xml
  def index
    @playgrounds = Playground.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playgrounds }
    end
  end

  # GET /playgrounds/1
  # GET /playgrounds/1.xml
  def show
    @playground = Playground.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @playground }
    end
  end

  # GET /playgrounds/new
  # GET /playgrounds/new.xml
  def new
    @playground = Playground.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playground }
    end
  end

  # GET /playgrounds/1/edit
  def edit
    @playground = Playground.find(params[:id])
  end

  # POST /playgrounds
  # POST /playgrounds.xml
  def create
    @playground = Playground.new(params[:playground])

    respond_to do |format|
      if @playground.save
        format.html { redirect_to(@playground, :notice => 'Playground was successfully created.') }
        format.xml  { render :xml => @playground, :status => :created, :location => @playground }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playground.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playgrounds/1
  # PUT /playgrounds/1.xml
  def update
    @playground = Playground.find(params[:id])

    respond_to do |format|
      if @playground.update_attributes(params[:playground])
        format.html { redirect_to(@playground, :notice => 'Playground was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playground.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playgrounds/1
  # DELETE /playgrounds/1.xml
  def destroy
    @playground = Playground.find(params[:id])
    @playground.destroy

    respond_to do |format|
      format.html { redirect_to(playgrounds_url) }
      format.xml  { head :ok }
    end
  end
end
