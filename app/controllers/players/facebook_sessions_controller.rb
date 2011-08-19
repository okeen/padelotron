class Players::FacebookSessionsController < ApplicationController
  
  before_filter :load_facebook_player_data

  def login
    @player = Player.find_or_create_by_name_and_email(
                        params[:player][:facebook_id].to_i,
                        params[:player][:name],
                        params[:player][:email]
                      )
    if @player and sign_in(@player)
      session[:facebook_access_token] = params[:facebook_access_token]
      cookies[:_padelotron_tcg]= { :value => "1", :expires => 15.minutes.from_now.utc}
      render :json => {
                :message => "Kaixo #{@player.name}",
                :model => @player}.to_json,
                :status => :created
    else
      render :json => {
                :message => "Error",
                :model => @player}.to_json,
                :status => :unprocessable_entity
    end
  end

  def logout
    @player = Player.find_by_facebook_id(params[:player][:facebook_id].to_i)
    if @player and sign_out(@player)
      cookies[:_padelotron_tcg]= nil
      render :json => {
                :message => "Logged out #{@player.name}",
                :model => @player}.to_json,
                :status => :ok
    else
      render :json => {
                :message => "Error",
                :model => @player}.to_json,
                :status => :unprocessable_entity
    end
  end


end