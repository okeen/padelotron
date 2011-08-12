class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @player = Player.find_for_facebook_oauth(env["omniauth.auth"], current_player)

    if @player.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @player, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end