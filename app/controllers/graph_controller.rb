class GraphController < ApplicationController
  def graph_code
    @player = Player.find(params[:id])
    title = Title.new("Games wins and lost")

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# of #total#<br>#percent# of 100%'
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]

    contWins = 0
    contPlayed = 0
    @player.player_games.each do |game|
      unless  game.winner_team.nil?
        contPlayed = contPlayed +1
        if game.winner_team.player1.id == @player.id || game.winner_team.player2.id == @player.id
        #if game.played_by_player(@player)
          contWins = contWins +1
        end
      end
    end

    newValues = [PieValue.new(contWins,"Wins"),PieValue.new(contPlayed-contWins,"Lost")]
    pie.values  = newValues

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)

    chart.x_axis = nil

    render :text => chart.to_s
  end


  def graph_games_played
    @player = Player.find(params[:id])
    title = Title.new("Games played in last month")

    today = Date.today
    last_month = today - 1.month

    values = Hash.new

    4.times do |time|
      last_month = last_month + 7.days
      start_date = last_month.beginning_of_week
      end_date = last_month.end_of_week
      @player.teams.each do |team|
        team.games.each do |game|
          if game.play_date >= start_date && game.play_date <=end_date
            if values.has_key?(start_date)
              values[start_date]=values[start_date]+1
            else
              values[start_date ] = 1
            end
          end
        end
      end
    end

    values.sort
    data = []
    puts("-----------------------------")
    values.values.each do |val|
      data << val
    end
    puts(data)
    puts("--- #{values.values} --- #{data}")
    puts("----------------")
#    line_dot = LineDot.new
#    line_dot.text = "Line Dot"
#    line_dot.width = 4
#    line_dot.colour = '#DFC329'
#    line_dot.dot_size = 5
#    line_dot.values = data1
#
#    line_hollow = LineHollow.new
#    line_hollow.text = "Line Hollow"
#    line_hollow.width = 1
#    line_hollow.colour = '#6363AC'
#    line_hollow.dot_size = 5
#    line_hollow.values = data2

    line = Line.new
    line.text = "Line"
    line.width = 1
    line.colour = '#5E4725'
    line.dot_size = 5
    line.values = data

    y = YAxis.new
    y.set_range(0,110,5)

    x_legend = XLegend.new("MY X Legend")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("MY Y Legend")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.y_axis = y
    chart.add_element(line)

    render :text => chart.to_s
  end
end