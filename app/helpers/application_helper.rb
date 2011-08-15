module ApplicationHelper

  def top_navigation_menu
    content_tag :ul, :id => 'nav' do |ul|
      (
      "<li>#{link_to("Players", players_path)}</li>"+
      "<li>#{link_to("Teams", teams_path)}</li>"+
      "<li>#{link_to("Games", games_path)}</li>"+
      "<li>#{link_to("Create a Game", new_game_path)}</li>"
        ).html_safe
    end
  end

  def player_photo(player, options = {})
    photo_url = player.facebook_url + "/picture"
    photo_url+= "?type=#{options[:size].to_s}" if options[:size]
    link_to image_tag(photo_url), player.facebook_url
  end
  
end

