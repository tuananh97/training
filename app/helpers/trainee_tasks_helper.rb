module TraineeTasksHelper
  def check_status_task user_id, task_id
    @trainee_task = TraineeTask.find_trainee_task(user_id, task_id)
  end

  def find_trainee_task id
    @trainee_task = TraineeTask.find_by task_id: id

    return @trainee_task if @trainee_task
    flash[:danger] = t ".not_found"
  end
end
