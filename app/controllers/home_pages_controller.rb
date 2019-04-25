class HomePagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.get_notifications.reverse
    @my_courses = current_user.courses.page(params[:page])
                        .per Settings.per_page
    @supervisor_courses = current_user.courses.page(params[:page])
                                      .per Settings.per_page
  end
end
