class Supervisor::TasksController < Supervisor::BaseController
  before_action :find_subject, :find_course
  before_action :find_task, except: [:new, :create]

  def new
    @task = @subject.tasks.build
  end

  def create
    @task = @subject.tasks.build task_params
    ActiveRecord::Base.transaction do
      @task.save!
      assign_task
      send_notice if TraineeSubject.where(subject_id: @subject.id).exists?
      flash[:success] = t ".success"
      redirect_to supervisor_course_path @course
    end
  rescue StandardError
    flash[:error] = t ".failure"
    render :new
  end

  def show; end

  def edit; end

  def update
    if @task.update_attributes task_params
      flash[:success] = t ".success"
      redirect_to supervisor_course_path @course
    else
      flash[:error] = t ".failure"
      render :edit
    end
  end

  def destroy
    if @task.destroy
      TraineeTask.where(task_id: @task.id).delete_all
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to supervisor_course_path @course
  end

  private

  def task_params
    params.require(:task).permit :name, :description, :content, :video
  end

  def assign_task
    TraineeSubject.where(subject_id: @subject.id).each do |user|
      TraineeTask.bulk_insert(ignore: true) do |work_task|
        work_task.add(task_id: @task.id, trainee_id: user.trainee_id,
        course_id: @course.id)
      end
    end
  end

  def send_notice
    TraineeSubject.where(subject_id: @subject.id).each do |user|
      Notification.create content: t(".assign", task: @task.name), user_id: user.trainee_id, is_read: false
    end
  end

  def find_task
    @task = Task.find_by_id params[:id]
    return if @task
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def find_course
    @course = Course.find_by_id params[:course_id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def find_subject
    @subject = Subject.find_by_id params[:subject_id]
    return if @subject
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end
end
