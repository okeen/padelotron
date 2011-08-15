module TeamsHelper

  def team_photo(team, options = {})
    image_tag(team.image.url)
  end


end
