module GamesHelper

  def game_title(game)
    content_tag :h2, "Friendly game between #{game.team1.name} and #{game.team2.name}"
  end

  def set_game_result_button(game)
    "<form><button onclick='return false' class='set_game_result_button'>Set the result</button></form>".html_safe
  end

  def first_team_info(game)
    team_info_for_game_team(game, :first)
  end

  def second_team_info(game)
    team_info_for_game_team(game, :second)
  end

  def team_info_for_game_team(game, team_number)
    team = team_number == :first ? game.team1 : game.team2
    content_tag :div,
      image_tag(team.image.url) + "<h3>#{team.name}</h3>".html_safe,
      :class => "#{team_number}_team"
  end

  def game_date_and_location(game)
    content_tag :h4, "#{game.play_date}", :class => "play_date"
  end

  def game_like_button(game)

  end

  def game_rating_mini_stars(game)
    
  end

  def show_game_link(game)
    link_to "View", game_path(game)
  end

  def facebook_game_comments_panel(game)
    "<fb:comments href='#{game_url(game)}' num_posts='10' width='500'></fb:comments>".html_safe
  end
end
