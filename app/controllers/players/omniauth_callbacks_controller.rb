class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  before_filter :log_oauth_params

  def facebook
    @player = Player.find_for_facebook_oauth(env["omniauth.auth"], current_player)
    if @player.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      cookies[:_padelotron_tcg]= { :value => "1", :expires => 30.minutes.from_now.utc}
      sign_in_and_redirect @player, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private

  def log_oauth_params
    logger.info "OAuth: " + env["omniauth.auth"].inspect
  end

end