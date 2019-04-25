class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reverse
  end

  def new
    @new_notification = Notification.new
    render layout: false
  end

  private

  def event_params
    params.require(:notification).permit :content
  end
end
