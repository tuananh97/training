class Admin::CoursesController < Admin::BaseController
  before_action :find_course, except: %i(index)

  def index
    @courses = Course.by_lastest.page(params[:page]).per Settings.per_page_index
  end

  def show
    @subjects = @course.subjects.includes :exams, :tasks
    @trainees = @course.users.trainee
    @supervisors = @course.users.supervisor
  end

  private

  def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to admin_courses_path
  end
end
