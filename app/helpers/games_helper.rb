module GamesHelper

  def game_title(game)
    content_tag :h2, "Friendly game between #{game.team1.name} and #{game.team2.name}",
              :name=>"title"
  end

  def new_game_link
    content_tag :div, :class=> "new_item_creation clickable_container" do |div|
      link_to 'Create a New game', new_game_path
    end
  end

  def games_catalogue_header
    content_tag :div, :class=> 'catalogue_header' do
#        (
#        content_tag :div, :class => 'catalogue_header_tab clickable_container z-index-2  last_tab'do
#          link_to "Latests", root_path
#        end
#      )+  (
#        content_tag :div, :class => 'catalogue_header_tab clickable_container z-index-1 ' do
#          link_to "Favourites", root_path
#        end
#      )

    end
  end

  def show_games_or_results_links_panel
    content_tag :div, :id => "show_games_or_results_links_panel" do |div|
      (content_tag :div, :class => "show_games current clickable_container" do |games_div|
        link_to "Games"
      end) +
      (content_tag :div, :class => "show_results clickable_container" do |results_div|
        link_to "Results"
      end)
    end
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
    players_list= content_tag(:ul, :class=>"team_players_list" ) do |ul|
      team.players.collect { |player|
        content_tag :li, link_to(player.name, player_path(player)), :class => "player"
      }.join("\n").html_safe
    end
    content_tag :div,
      image_tag(team.image.url) + "<h3>#{link_to team.name, team_path(team)}</h3>".html_safe + players_list ,
      :class => "#{team_number}_team clickable_container"
  end

  def game_date_and_location(game)
    date_str = game.play_date.strftime("%b %d, %H:%M")
    returning = content_tag :h4, date_str, :class => "game_date_location"
    if game.playground
      returning+= link_to "@#{game.playground.name} (#{game.playground.city})".html_safe,
        place_path(game.playground.place), :class => "game_date_location"
    else
      returning.html_safe
    end
  end

  def game_like_button(game)
    "<fb:like href='#{game_url(game)}' send='true' width='450' show_faces='true' action='like' font='arial'></fb:like>".html_safe
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
