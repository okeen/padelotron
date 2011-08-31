class Customers::GraphicController < ApplicationController
  helper :customers
  layout 'customers'
  before_filter :authenticate_customer!, :load_customer
  
  def show
    numDay = 0
    numWeek = 0
    numMonth = 0
    today = DateTime.now
    week = today.beginning_of_week
    month = today.beginning_of_month
    puts('-----------------------')
    @customer.places.each do |place|
      
      place.playgrounds.each do |play|
        puts('placccccccccccccccccccccccccce')
        puts(play.games.count)
        play.games.each do |game|

          puts('---------------popo')
          puts(game.play_date)
          if game.play_date == today
            numDay = numDay + 1
          end
          if game.play_date <=today && game.play_date >= week
            numWeek = numWeek +1
          end
          if game.play_date <= today && game.play_date >= month
            numMonth = numMonth +1
          end
        end
      end
    end
    
    respond_to do |format|
      format.html
    end
  end

  private

  def load_customer
    @customer = current_customer
  end
end