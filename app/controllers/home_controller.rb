class HomeController < ApplicationController
  before_filter :authenticate_player!,
                :redirect_to_confirmation_from_facebook_request


  def home

  end

  private

  def redirect_to_confirmation_from_facebook_request
    if params[:request_ids]
      @confirmation = Confirmation.find_by_facebook_request_id(params[:request_ids])
      redirect_to show_confirmation_path(@confirmation.code) and return false
    end
  end
end
