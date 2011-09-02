class NotificationsController < ApplicationController
  before_filter :authenticate_player!, :load_player
  # GET /notifications
  # GET /notifications.xml
  def index
    @notifications = @player.notifications.unread.all

    respond_to do |format|
      format.json  { render :json => @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    @notification = @player.notifications.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification }
    end
  end


  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    @notification = @player.notifications.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to(@notification, :notice => 'Notification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification = @player.notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to(notifications_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_player
    @player = current_player
  end


end
