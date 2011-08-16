class Players::FacebookSessionsController < ApplicationController
  
  before_filter :load_facebook_player_data

  def login
    @player = Player.find_by_facebook_id(params[:player][:facebook_id])
    if @player and sign_in(@player)
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
    @player = Player.find_by_facebook_id(params[:player][:facebook_id])
    if @player and sign_out(@player)
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