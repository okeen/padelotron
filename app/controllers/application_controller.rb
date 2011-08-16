class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

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
end
