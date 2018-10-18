class Trainee::TasksController < ApplicationController
  before_action :find_task, only: [:show, :update]

  def show
    @trainee_task = TraineeTask.find_by task_id: @task.id

    unless @trainee_task.finish?
      @trainee_task.update_attributes status: :inprogress
    end
  end

  def update
    @trainee_task = TraineeTask.find_by task_id: @task.id

    if @trainee_task.update_attributes status: :finish
      flash[:success] = t ".success"
      redirect_to trainee_task_path @task
    else
      flash[:danger] = t ".failure"
      redirect_to trainee_task_path @task
    end
  end

  private

  def find_task
    @task = Task.find_by_id params[:id]

    return if @task
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
