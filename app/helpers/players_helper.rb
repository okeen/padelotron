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

  def players_catalogue_header
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

  def players_letter_filter_links_sidebar
    content_tag :div, :id=>'catalogue_filter_letters' do
      ('A'..'Z').to_a.collect { |letter|
        content_tag :div, :class => 'letter_filter_letter_container clickable_container' do
          link_to letter, players_catalog_letter_path(letter)
        end
      }.join(" ").html_safe
    end
  end

end
