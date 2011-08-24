class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def facebook_access_token
    session[:facebook_access_token]
  end

  def facebook_app_access_token
    oauth = Koala::Facebook::OAuth.new(
      Padelotron::Application.config.facebook[Rails.env][:app_id],
      Padelotron::Application.config.facebook[Rails.env][:app_secret])
    token = oauth.get_app_access_token
    logger.debug "FB client token: #{token}"
    token
  end

  def facebook_app_graph_path
    "/#{Padelotron::Application.config.facebook[Rails.env][:app_id]}"
  end

  def load_facebook_player_data
    token = params[:facebook_access_token]
    unless token.blank?
      graph = Koala::Facebook::API.new(token)
      player_data = graph.api "me"
      params[:player] = {
        'name' => player_data['name'],
        'facebook_id' => player_data['id'],
        'email' => player_data['email']
      }
      logger.info "Facebook user: #{params[:player].inspect}"
    end
  end

  def after_sign_up_path_for(resource)
    customer_path(resource)
  end

  def after_confirmation_path_for(resource)
    customer_path(resource)
  end

  def after_sign_in_path_for(resource)
    customer_path(resource)
  end

end
