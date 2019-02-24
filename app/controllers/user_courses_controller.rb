class UserCoursesController < ApplicationController
  before_action :check_enroll_course, only: :create

  def create
    @course = Course.find_by_id params[:user_course][:course_id]
    if @course.assign_user current_user
      assgin_course if current_user.trainee?
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failed"
    end
    redirect_to home_path
  end

  def destroy
    @user_course = UserCourse.find_by_id params[:id]
    @course = @user_course.course
    @user = @user_course.user
    @user_course_id = @user_course.id
    if @user.trainee?
      @trainee = User.find_by_id @user.id
      @trainee.trainee_tasks.where(course_id: @course.id).delete_all
      @trainee.trainee_subjects.where(course_id: @course.id).delete_all
    end
    if @course.remove_user @user
      flash[:success] = t ".success"
      redirect_to home_path
    else
      flash[:error] = t ".failed"
      redirect_to :back
    end
  end

  private

  def user_course_params
    params.require(:user_courses).permit :course_id, :user_id
  end

  def check_enroll_course
    @user_course = current_user.user_courses.where(course_id:
      params[:user_course][:course_id])
    if @user_course.present?
      flash[:info] = t ".info"
      redirect_to home_path
    end
  end

  def assgin_course
    TraineeSubject.bulk_insert(ignore: true) do |worker_subject|
      @course.subjects.each do |subject|
        worker_subject.add(trainee_id: current_user.id, subject_id: subject.id,
        course_id: @course.id)
        TraineeTask.bulk_insert(ignore: true) do |work_task|
          subject.tasks.each do |task|
            work_task.add(trainee_id: current_user.id, task_id: task.id,
            course_id: @course.id)
          end
        end
      end
    end
  end
end
