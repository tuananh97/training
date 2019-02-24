class LearnsController < HomePagesController
  before_action :find_course

  def show
    @subjects = @course.subjects
    return unless UserCourse.find_by(user_id: current_user, course_id:
      @course.id).nil?
    flash[:error] = t ".not_permission"
    redirect_to root_path
  end

  private

  def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
