class Trainee::CoursesController < Trainee::BaseController
  before_action :check_course, only: [:show, :show_member]

  def index
    @my_courses = Course.trainee_courses(current_user.id).page(params[:page])
                        .per Settings.per_page
  end

  def show; end

  def show_member
    @member = @course.users.order(role: :desc).page(params[:page])
                     .per Settings.per_page
  end

  private

  def check_course
    find_course
    if UserCourse.find_by(user_id: current_user, course_id: @course.id).nil?
      flash[:error] = t ".not_permission"
      redirect_to root_path
    end
  end

  def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
