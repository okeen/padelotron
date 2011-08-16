module TeamsHelper

  def team_photo(team, options = {})
    image_tag(team.image.url)
  end

  def team_emblems(team)
    "".html_safe
  end

  def facebook_comments_panel(team)
    "<fb:comments href='#{team_url(team)}' num_posts='10' width='500'></fb:comments>".html_safe
  end

  def team_like_button(team)
    "<fb:like href='#{team_url(team)}' send='true' width='450' show_faces='true' action='like' font='arial'></fb:like>".html_safe
  end
end
