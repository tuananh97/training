class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reverse
  end

  def new
    @new_notification = Notification.new
    render layout: false
  end

  def create
    @notification = current_user.notifications.build event_params
    if @notification.save
      flash[:success] = "Create success."
      redirect_to notifications_path
    end
  end

  private

  def event_params
    params.require(:notification).permit :content
  end
end
