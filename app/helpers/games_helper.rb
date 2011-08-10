module GamesHelper

  def game_title(game)
    content_tag :h2, "Friendly game between #{game.team1.name} and #{game.team2.name}"
  end

  def set_game_result_button(game)
    "<form><button onclick='return false' class='set_game_result_button'>Set the result</button></form>".html_safe
  end
end
