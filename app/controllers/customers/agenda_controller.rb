class Customers::AgendaController < ApplicationController
  helper :customers
  layout 'customers'
  before_filter :authenticate_customer!, :load_customer
  
  def show
    respond_to do |format|
      format.html 
    end
  end

  def games
    @place=Place.includes(:games).find(params[:place_id])
    #games = @place.games.upcoming
    games = @place.games.includes(:team1,:team2).all
    respond_to do |format|
      format.json {render :json => games.to_json}
    end
  end

  private

  def load_customer
    @customer = current_customer
  end
end
