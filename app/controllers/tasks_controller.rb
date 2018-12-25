class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:show, :update]

  def show
    @comments = @task.comments.where(parent_id: nil).order(created_at: :desc)
    @comment = @task.comments.build
  end

  def update
    @trainee_task = TraineeTask.find_by(task_id: @task.id, trainee_id: current_user.id)
    if @trainee_task.update status: :finish
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to task_path @task
  end

  private

  def find_task
    @task = Task.find_by_id params[:id]
    if current_user.trainee?
      if TraineeTask.where(task_id: @task.id,
        trainee_id: current_user.id).present?
        return @task
      else
        flash[:danger] = t ".not_found"
        redirect_to root_path
      end
    end
  end
end
