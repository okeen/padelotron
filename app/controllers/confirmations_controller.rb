class ConfirmationsController < ApplicationController
  before_filter :load_confirmation_and_confirmable
  
  def show
    respond_to do |format|
      format.html
    end
  end

  def do_confirmation
    if (@confirmation.action == 'accept')
      @confirmable.confirm!
    else
      @confirmable.reject!
    end
  end

  private
  def load_confirmation_and_confirmable
    @confirmation = Confirmation.find_by_code(params[:code])
    @confirmable = @confirmation.confirmable_type.constantize.send(:with_exclusive_scope) {@confirmation.confirmable}
  end
end
