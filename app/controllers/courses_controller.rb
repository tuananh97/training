class CoursesController < ApplicationController
  before_action :find_course

  def new
    @user_course = UserCourse.new
  end

  def create
    @user_course = UserCourse.new user_course_params
    if @user_course.save
      @user_course = current.user_courses.find_by(course_id: @course.id)
      @course = Course.find_by_id @course.id
      set_trainee_course
    else
      flash[:error] = t "supervisor.courses.button.add_user.failed"
      redirect_to :back
    end
  end

  def destroy
    @course = @user_course.course
    @user = @user_course.user
    @user_course_id = @user_course.id
    if @user.trainee?
      @trainee = User.find_by_id @user.id
      @trainee.trainee_tasks.where(course_id: @course.id).delete_all
      @trainee.trainee_subjects.where(course_id: @course.id).delete_all
    end
  end

  private

  def user_course_params
    params.require(:user_courses).permit :course_id, :user_id
  end

  def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end

  def set_trainee_course
    TraineeSubject.bulk_insert(ignore: true) do |worker_subject|
      @course.subjects.each do |subject|
        worker_subject.add(trainee_id: @user.id, subject_id: subject.id,
        course_id: @course.id)
          TraineeTask.bulk_insert(ignore: true) do |work_task|
            subject.tasks.each do |task|
              work_task.add(trainee_id: @user.id, task_id: task.id,
                course_id: @course.id)
            end
          end
      end
    end
  end
end
