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
    games = Game.send(:with_exclusive_scope) {
      Game.includes(:team1,:team2).joins(:playground).where("playgrounds.place_id = ?", @place.id).all

    }
    respond_to do |format|
      logger.info "Retsurning games: #{games.inspect}"
      format.json {render :json => games.to_json}
    end
  end

  private

  def load_customer
    @customer = current_customer
  end
end
