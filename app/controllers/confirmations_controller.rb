class ConfirmationsController < ApplicationController
  before_filter :load_confirmation_and_confirmable, :authenticate_player!
  
  def show
    respond_to do |format|
      format.html
    end
  end

  def do_confirmation
    if (@confirmation.action == 'accept')
      @confirmable.confirm!
       if @confirmable.class == Game and @confirmable.create_facebook_event
         @confirmable.confirm_facebook_event_attendance(current_player,facebook_access_token)
       end

    else
      @confirmable.reject!
    end
  end

  def update
    respond_to do |format|
      if @confirmation.update_attributes(params[:confirmation])
        format.js  { head :ok }
      else
        format.js  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  private
  def load_confirmation_and_confirmable
    @confirmation = Confirmation.find_by_code(params[:code])
    @confirmable = @confirmation.confirmable_type.constantize.send(:with_exclusive_scope) {@confirmation.confirmable}
  end
end
