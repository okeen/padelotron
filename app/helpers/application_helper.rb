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

  def facebook_app_id
    app_id = Padelotron::Application.config.facebook[RAILS_ENV][:app_id]
    "<script type='text/javascript'>window._facebook_app_id='#{app_id}'</script>".html_safe
  end
  
  def player_photo(player, options = {})
    photo_url = player.facebook_url + "/picture"
    photo_url+= "?type=#{options[:size].to_s}" if options[:size]
    link_to image_tag(photo_url), "http://www.facebook.com/#{player.facebook_id}"
  end

  def  player_achievements(player)
    content_tag :ul, "Achievements", :class => "player_achievements" do |ul|
      achievements = player.achievements.inject("") do |list, achievement|
        content_tag :li, achievement_image(achievement), :class => 'achievement'
      end
      achievements.html_safe
    end
  end

  def google_analytics
    "<script type='text/javascript'>
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-25216991-1']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
  </script>".html_safe
  end

  def facebook_metadata_tags(resource)
    links = resource.collect do |tag,value|
      content_tag :meta, "", :property => tag, :content => value
    end
    links.join("\n").html_safe
  end
end

