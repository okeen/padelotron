class PlayersController < ApplicationController
  before_filter :load_facebook_metadata, :only => :show
  before_filter :load_facebook_player_data, :only => :create
  before_filter :authenticate_player!, :only => :home

  # GET /players
  # GET /players.xml
  def index
    @players = Player.includes(:stat).includes(:achievements)
    @players = @players.by_letter(params[:letter]) unless params[:letter].blank?
    @players =@players.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {:results => @players}}
    end
  end

  def home
    @player = Player.includes(:stat).includes(:achievements).find(current_player.id)
  end
  
  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.includes(:stat).includes(:achievements).find(params[:id])
#    @graphGamesWinLost = open_flash_chart_object(600,300,"/players/#{params[:id]}/graph_code")
#    @graphGamesPlayed = open_flash_chart_object(600,300,"/players/#{params[:id]}/graph_games_played")

    respond_to do |format|
      format.html {
            if request.xhr?
              render :partial => 'player_panel', :locals => {:player=> @player}
            end
      }
      format.js { }
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
        format.js  { render :json => {},   :status => :created}
      else
        format.html { render :action => "new" }
        format.js  { render :json => @player.errors, :status => :unprocessable_entity }
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
end
