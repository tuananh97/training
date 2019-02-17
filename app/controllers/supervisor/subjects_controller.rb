class Supervisor::SubjectsController < Supervisor::BaseController
  before_action :find_course
  before_action :find_subject, except: [:new, :create, :finish]

  def new
    @subject = @course.subjects.build
    Settings.task_times.times do
      @subject.tasks.build
    end
  end

  def create
    @subject = @course.subjects.build subject_params
    if @subject.save!
      assign_subject
      flash[:success] = t ".success"
      redirect_to supervisor_courses_path
    else
      flash[:error] = t ".failure"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      assign_task
      flash[:success] = t ".success"
      redirect_to supervisor_courses_path
    else
      flash[:error] = t ".failure"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      TraineeTask.where(course_id: @course.id).delete_all
      TraineeSubject.where(course_id: @course.id).delete_all
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  def finish
    @subject = Subject.find_by_id params[:subject_id]

    if @subject.update_attributes status: :finish
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description, :start_time,
      :end_time, :status, tasks_attributes: [:id, :name, :description,
      :content, :video, :destroy]
  end

  def assign_subject
    UserCourse.trainees_on_course(@course.id).each do |user|
      TraineeSubject.bulk_insert(ignore: true) do |worker_subject|
        @course.subjects.each do |subject|
          worker_subject.add(trainee_id: user.user_id, subject_id: subject.id,
          course_id: @course.id)
            TraineeTask.bulk_insert(ignore: true) do |work_task|
              subject.tasks.each do |task|
                work_task.add(trainee_id: user.user_id, task_id: task.id,
                  course_id: @course.id)
              end
            end
        end
      end
    end
  end

  def assign_task
    TraineeSubject.trainees_on_subject(@course.id, @subject.id).each do |user|
      TraineeTask.bulk_insert(ignore: true) do |work_task|
        @subject.tasks.task_not_assign_trainee.each do |task|
          work_task.add(task_id: task.task_id_new, trainee_id: user.trainee_id,
          course_id: @course.id)
        end
      end
    end
  end

  def find_subject
    @subject = Subject.find_by_id params[:id]

    return if @subject
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def find_course
    @course = Course.find_by_id params[:course_id]

    return if @course
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end
end
