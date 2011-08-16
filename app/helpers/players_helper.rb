module PlayersHelper

  def player_achievements_panel(player)
    content_tag :ul,nil ,:class => "player_emblems_list"
  end
  
  def player_like_button(player)
    "<fb:like href='#{player_url(player)}' send='true' width='450' show_faces='true' action='like' font='arial'></fb:like>".html_safe
  end

  def facebook_player_comments_panel(player)
    "<fb:comments href='#{player_url(player)}' num_posts='10' width='500'></fb:comments>".html_safe
  end
end
