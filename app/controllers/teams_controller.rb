class TeamsController < ApplicationController
  before_filter :authenticate_player!, :except => [:index, :show]
  before_filter :load_facebook_metadata, :only => :show

   # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.scoped.includes(:player1,:player2)
    @teams = @teams.where('name like ?', "%#{params[:q]}%") unless params[:q].blank?
    @teams = @teams.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {:results => @teams}}
    end
  end

  def available
    @teams = Team.available_for_today.all

    respond_to do |format|
      format.html { render :action => 'index'}
      format.xml  { render :xml => @teams }
    end
  end


  def my
    @teams = current_player.teams
      respond_to do |format|
        format.json { render :json => {:results => @teams}}
      end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html {
        if request.xhr?
              render :partial => 'team_panel', :locals => {:team=> @team}
            end
      }
      format.json { render :json => {:model => @team}}
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team].merge(:player1_id => current_player.id))

    respond_to do |format|
      if @team.save
        message = "Team creation process opened. An email have been sent to #{@team.player2.name} to confirm the team creation"
        format.html { redirect_to(@team, :notice => message) }
        format.json  { render :json =>{:message => message, :model => @team}.to_json, :status => :created}
      else
        format.html { render :action => "new" }
        format.json  { render :json =>@team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_facebook_metadata
    @team = Team.send(:with_exclusive_scope) {Team.find(params[:id])}
    @facebook_metadata_tags = {
      'og:title' => @team.name,
      'og:type' => 'sports_team',
      'og:url' => team_url(@team),
      'og:image' => @team.image.url,
      'og:site_name' => "Padelotron",
      'fb:app_id' => "270031589679955",
      'og:description' => "#{@team.name} page at Padelotron"
    }
  end
end
