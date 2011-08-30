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
    gamesWin = Hash.new
    allLabels = []

    4.times do |time|
      last_month = last_month + 7.days
      start_date = last_month.beginning_of_week
      end_date = last_month.end_of_week
      allLabels << "#{start_date} \n #{end_date}"
      @player.teams.each do |team|
        team.games.each do |game|
          if game.play_date >= start_date && game.play_date <=end_date
            if values.has_key?(start_date)
              values[start_date]=values[start_date]+1
            else
              values[start_date ] = 1
            end

            if game.winner_team.player1.id == @player.id || game.winner_team.player2.id == @player.id
              if gamesWin.has_key?(start_date)
                gamesWin[start_date] = values[start_date] + 1
              else
                gamesWin[start_date] = 1
              end
            end
          end
        end
      end
    end

    values.sort
    data = []
    wins = []
    lost = []
    
    values.values.each do |val|
      data << val
    end

    cont=0
    gamesWin.values.each do |val|
      wins << val
      lost << data[cont]-val
      cont = cont + 1
    end

    line = Line.new
    line.text = "Games played"
    line.width = 1
    line.colour = '#5E4725'
    line.dot_size = 5
    line.values = data

    lineWin = Line.new
    lineWin.text = "Games win"
    lineWin.width = 1
    lineWin.colour = '#DFC329'
    lineWin.dot_size = 5
    lineWin.values = wins

    lineLost = Line.new
    lineLost.text = "Games lost"
    lineLost.width = 1
    lineLost.colour = '#6363AC'
    lineLost.dot_size = 5
    lineLost.values = lost

    order = data.sort
    y = YAxis.new
    y.set_range(0,order.last+(order.last * 0.1),1)

    x_legend = XLegend.new("Weeks")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("Games")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    labels = XAxisLabels.new
    labels.text = allLabels
    labels.steps = 86400
    labels.visible_steps = 1

    x = XAxis.new
    x.labels = labels

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.y_axis = y
    chart.x_axis = x
    chart.add_element(line)
    chart.add_element(lineWin)
    chart.add_element(lineLost)

    render :text => chart.to_s
  end
end