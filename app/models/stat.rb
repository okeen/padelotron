class Stat < ActiveRecord::Base

  belongs_to :statable , :polymorphic => true

  def Stat.update_all_for_game(game)
    game.teams.each do |team|
      if game.result.winner.id == team.id
        #        puts "#{game.description}:#{team.name} won"
        team.stat.add_victory
      else
        #        puts "#{game.description}:#{team.name} lost"
        team.stat.add_defeat
      end
      
      #      puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Stat saved"
      #      puts "#{game.description}:#{team.name}: #{stat.wins}/#{stat.lost}"
    end
    #    puts "##---------------------------------------"
  end

  def add_victory
    self.wins+= 1
    self.win_strike+=1
    #puts "Victory for: #{statable.name}: #{wins}/#{lost}"
    if statable.class == Team
      statable.players.each {|player| player.stat.add_victory}
    end
    update_percent
    save
  end

  def add_defeat
    self.lost+= 1
    self.win_strike= 0
    #puts "Defeat for: #{statable.name}: #{wins}/#{lost}"
    if statable.class == Team
      statable.players.each {|player| player.stat.add_defeat}
    end
    update_percent
  end

  def update_percent
    if wins == 0
      self.win_percent= 0
    else if lost == 0
        self.win_percent = 0
      else
        win_percent == (100 * wins) / (wins + lost)
      end
    end
    save
  end
end
