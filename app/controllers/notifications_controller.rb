class NotificationsController < ApplicationController
  before_filter :authenticate_player!, :load_player
  # GET /notifications
  # GET /notifications.xml
  def index
    @notifications = @player.notifications.all

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
      format.json  { render :xml => @notification }
    end
  end


  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    @notification = @player.notifications.find(params[:id])
    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.json  { head :ok }
      else
        format.json render :json => { :message => @notification.errors },
                          :status => :unprocessable_entity
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification = @player.notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end

  private

  def load_player
    @player = current_player
  end


end
