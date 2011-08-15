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
end
