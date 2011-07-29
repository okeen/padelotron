module ApplicationHelper

  def top_navigation_menu
    content_tag :ul, :id => 'nav' do |ul|
      (
      "<li>#{link_to("Players", players_path)}</li>"+
      "<li>#{link_to("Teams", teams_path)}</li>"
        ).html_safe      
    end
  end
end

