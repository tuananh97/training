class LearnsController < HomePagesController
  before_action :find_course

  def show
    if UserCourse.find_by(user_id: current_user, course_id:
      @course.id).nil?
    flash[:error] = t ".not_permission"
    redirect_to root_path
    else
      @subjects = @course.subjects
    end
  end

  def exam_details
   find_exam
   @tests = current_user.tests.where(exam_id: @exam.id)
  end

  private

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

