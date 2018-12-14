class LearnsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course, only: :show

  def show; end

  private

  def find_course
    @course = Course.find_by_id params[:id]
    if UserCourse.where(course_id: @course.id, user_id: current_user.id).present?
      return @course
    else
      flash[:danger] = t ".not_found"
      redirect_to root_path
    end
  end
end
