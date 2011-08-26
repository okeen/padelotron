class PlayersController < ApplicationController
  before_filter :load_facebook_metadata, :only => :show
  before_filter :load_facebook_player_data, :only => :create

  # GET /players
  # GET /players.xml
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])
    @graph = open_flash_chart_object(600,300,"/players/:id/graph_code")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])
    @player.full_address = params[:player][:full_address]
    
    respond_to do |format|
      if @player.save
        sign_in(@player)
        format.html { redirect_to(@player, :notice => 'Player created.') }
        format.js  { render :json => {
                                :message => "Player created", 
                                :model =>@player}.to_json,
                                :status => :created}
      else
        format.html { render :action => "new" }
        format.js  { render :json => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_facebook_metadata
    @player = Player.find(params[:id])
    @facebook_metadata_tags = {
      'og:title' => @player.name,
      'og:type' => 'athlete',
      'og:url' => player_url(@player),
      'og:image' => "http://graph.facebook.com/#{@player.facebook_id}/picture)",
      'og:site_name' => "Padelotron",
      'fb:app_id' => "270031589679955",
      'og:description' => "#{@player.name} page at Padelotron"
    }
  end

  def graph_code   
    @player = Player.find(params[:id])
    title = Title.new("Wins - lost")

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]

    contWins = 0
    @player.player_games.each do |game|
      if game.played_by_player(@player)
        contWins = contWins +1
      end
    end

    newValues = [2,3,4]
    pie.values  = newValues

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)

    chart.x_axis = nil

    render :text => chart.to_s
  end
end
