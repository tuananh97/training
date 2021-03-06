class TasksController < HomePagesController
  before_action :find_task

  def show
    check_permission
    @comments = @task.comments.not_has_parents
    @comment = @task.comments.build
  end

  def update
    @trainee_task = TraineeTask.find_by(task_id: @task.id, trainee_id: current_user.id)
    if @trainee_task.update status: :finish
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to my_progress_path @task.subject.course.id
  end

  private

  def check_permission
    if current_user.trainee?
      if TraineeTask.find_by(trainee_id: current_user, task_id: @task.id).nil?
        flash[:error] = t ".not_permission"
        redirect_to root_path
      end
    elsif current_user.supervisor?
      if UserCourse.find_by(user_id: current_user, course_id: @task.subject.course.id).nil?
        flash[:error] = t ".not_permission"
        redirect_to root_path
      end
    end
  end

  def find_task
    @task = Task.find_by_id params[:id]
    return if @task
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
