class GraphController < ApplicationController
  def graph_code
    @graph = open_flash_chart_object(600,300,"/players/#{params[:id]}/graph_code")
    @player = Player.find(params[:id])
    title = Title.new("Wins - lost")

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]

    contWins = 0
    @player.player_games.each do |game|
      #if game.played_by_player(@player)
       # contWins = contWins +1
      #end
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