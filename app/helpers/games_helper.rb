module GamesHelper

  def game_title(game)
    content_tag :h2, "Friendly game between #{game.team1.name} and #{game.team2.name}"
  end
end
