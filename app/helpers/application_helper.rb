module ApplicationHelper

  def top_navigation_menu
    content_tag :ul, :id => 'nav' do |ul|
      (
        "<li>#{link_to("Players", players_path)}</li>"+
          "<li>#{link_to("Teams", teams_path)}</li>"+
          "<li>#{link_to("Games", games_path)}</li>"+
          "<li>#{link_to("Create a Game", new_game_path)}</li>"+
          "<li>#{link_to("Places", places_path)}</li>"+
          "<li>#{link_to("Customers", customers_path)}</li>"
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

  def achievement_image(achievement_type_name, active=true)
    image_tag "achievements/#{achievement_type_name}.png",
      :alt => achievement_type_name,
      :class => "achievement_icon"
  end

  def grouped_achievements(achievements)
    achievements.inject({}) do |a,b|
      a[b.achievement_type.name]||=0
      a[b.achievement_type.name]+=1
      a
    end
  end

  def get_achievement_image_with_count(achievement_type_name, achievements_table)
    logger.debug "#{achievements_table.inspect}"
    count = achievements_table[achievement_type_name] || 0
    achievement_image(achievement_type_name, count > 0 )+" x #{count}".html_safe
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

  def google_maps
    '<script src="http://maps.google.com/maps/api/js?v=3.6&sensor=false&key=ABQIAAAA0ABhsi94_QBEemORCuekWhTQb5oFIWqRUhWFXeBCl1qnXIchCxR2d3ijdCwerkhVW1ZKviQkM41YpQ" type="text/javascript"></script>'.html_safe
  end

  def google_loader
    '<script type="text/javascript" src="https://www.google.com/jsapi?key=ABQIAAAA0ABhsi94_QBEemORCuekWhTQb5oFIWqRUhWFXeBCl1qnXIchCxR2d3ijdCwerkhVW1ZKviQkM41YpQ"></script>'.html_safe
  end


  def hidden_player_location_inputs(player)
    ("<input type='hidden' name='player_latitude' value='#{player.latitude}'></input>"+
        "<input type='hidden' name='player_longitude' value='#{player.longitude}'></input>").html_safe
  end


end
