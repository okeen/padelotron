module PlayersHelper

  def player_photo(player, options = {})
    photo_url = player.facebook_url + "/picture"
    photo_url+= "?type=#{options[:size].to_s}" if options[:size]
    link_to image_tag(photo_url), :url => player.facebook_url
  end

  def player_achievements_panel(player)
    content_tag :ul,nil ,:class => "player_emblems_list"
  end
end
