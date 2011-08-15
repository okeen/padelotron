module TeamsHelper

  def team_photo(team, options = {})
    image_tag(team.image.url)
  end

  def team_emblems(team)
    "".html_safe
  end
end
