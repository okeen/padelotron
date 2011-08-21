class Stat < ActiveRecord::Base

  belongs_to :statable , :polymorphic => true
  @@aa = 1
  def Stat.update_all_for_game(game)
    game.teams.each do |team|
      stat = team.stat
      if game.result.winner.id == team.id
#        puts "#{game.description}:#{team.name} won"
        stat.wins+= 1
      else
#        puts "#{game.description}:#{team.name} lost"
        stat.lost+= 1
      end
      if (stat.wins == 0)
        stat.win_percent = 0
      else if (stat.lost == 0 )
          stat.win_percent= 100
        else
          stat.win_percent = 100 * stat.wins / stat.lost
        end
      end
      stat.save
#      puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Stat saved"
#      puts "#{game.description}:#{team.name}: #{stat.wins}/#{stat.lost}"
    end
#    puts "##---------------------------------------"
  end
end
