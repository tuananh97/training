class LearnsController < HomePagesController
  before_action :find_course, except: :progress_details
  before_action :find_exam, only: :exam_details
  before_action :check_permission, except: :progress_details

  def show
    @members = @course.users.not_admin
    @subjects = @course.subjects.includes :exams, :tasks
  end

  def exam_details
   @tests = current_user.tests.where(exam_id: @exam.id)
  end

  def progress_details
    @course = Course.find_by_id params[:course_id]
    check_permission
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end

  private

  def check_permission
    if UserCourse.find_by(user_id: current_user, course_id: @course.id).nil?
      flash[:error] = t ".not_permission"
      redirect_to root_path
    end
  end

  def find_exam
    @exam = Exam.find_by_id params[:id]
    return if @exam
    flash[:error] = t ".not_found"
    redirect_to root_path
  end

  def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
