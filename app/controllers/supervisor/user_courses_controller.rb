class Supervisor::UserCoursesController < Supervisor::BaseController
  before_action :check_params, only: %i(create)
  before_action :set_user_course, only: %i(destroy)

  def create
    if @course.assign_user @user
      @user_course = @user.user_courses.find_by(course_id: @course.id)
      @course = Course.find_by_id @course.id
      set_trainee_course if @user.trainee?
      respond_to do |format|
        format.html{redirect_to edit_supervisor_course_path(@course)}
        format.js
      end
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
    if @course.remove_user @user
      remove_sucess
    else
      flash[:error] = t "supervisor.courses.button.remove_user.failed"
      redirect_to :back
    end
  end

  private

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

  def remove_sucess
    @user_course = @course.user_courses.build user_id: @user.id
    respond_to do |format|
      format.html{redirect_to edit_supervisor_course_path(@course)}
      format.js
    end
  end

  def set_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course
    flash[:error] = t ".error"
    redirect_to :back
  end

  def check_params
    @user = User.find_by id: params[:user_id]
    @course = Course.find_by id: params[:course_id]
    if @user && !@course
      flash[:error] = t "supervisor.courses.add_user.course_not_found"
      redirect_to new_supervisor_course_path
    end
    return if @course || @user
    flash[:error] = t ".error"
    redirect_to supervisor_courses_path
  end

  def course_subjects_params
    params.require(:user_courses).permit :course_id, :user_id
  end
end
