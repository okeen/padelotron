class GamesController < ApplicationController
  
  before_filter :authenticate_player!, :except => [:index, :show]
  before_filter :load_facebook_metadata, :only => :show

  # GET /games
  # GET /games.xml
  def index
    @upcoming_games = Game.to_play.limit(10).includes(:team1,:team2).all
    @recent_results = Game.finished.limit(10).includes(:team1,:team2).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  def upcoming
    @games = @games.upcoming
  end
  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        message = "Friendly game creation process initialized, an email has been send to #{@game.team2.name} to confirm the game."
        @game.create_facebook_game_event(current_player, facebook_app_access_token) if @game.create_facebook_event
        format.html { redirect_to(@game, :notice => message) }
        format.js  { render :json =>{:message => message, :model => @game}.to_json, :status => :created}
      else
        format.html { render :action => "new" }
        format.js  { render :json =>@game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_facebook_metadata
    @game = Game.send(:with_exclusive_scope) {Game.find(params[:id])}
    @facebook_metadata_tags = {
      'og:title' => @game.description,
      'og:type' => 'sports_game',
      'og:url' => game_url(@game),
      'og:site_name' => "Padelotron",
      'fb:app_id' => "270031589679955",
      'og:description' => "#{@game.description} page at Padelotron"
    }
  end

  def load_parent_place
    @place = Place.find(params[:place_id])
    @games = @place.games
  end
end
