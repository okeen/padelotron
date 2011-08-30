module TeamsHelper

  def team_photo(team, options = {})
    image_tag(team.image.url)
  end

  def team_emblems(team)
    "".html_safe
  end

  def teams_letter_filter_links_sidebar
    content_tag :div, :id=>'catalogue_filter_letters' do
      ('A'..'Z').to_a.collect { |letter|
        content_tag :div, :class => 'letter_filter_letter_container clickable_container' do
          link_to letter, teams_path
        end
      }.join(" ").html_safe
    end
  end


  def teams_catalogue_header
    content_tag :div, :class=> 'catalogue_header' do
        (
        content_tag :div, :class => 'catalogue_header_tab clickable_container z-index-2  last_tab'do
          link_to "Latests", root_path
        end
      )+  (
        content_tag :div, :class => 'catalogue_header_tab clickable_container z-index-1 ' do
          link_to "Favourites", root_path
        end
      ) 
    
    end
  end

  def facebook_comments_panel(team)
    "<fb:comments href='#{team_url(team)}' num_posts='10' width='500'></fb:comments>".html_safe
  end

  def team_like_button(team)
    "<fb:like href='#{team_url(team)}' send='true' width='450' show_faces='true' action='like' font='arial'></fb:like>".html_safe
  end
end
