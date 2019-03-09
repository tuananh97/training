class Supervisor::SubjectsController < Supervisor::BaseController
  before_action :find_course
  before_action :find_subject, except: %i(new create finish)

  def new
    @subject = @course.subjects.build
  end

  def create
    @subject = @course.subjects.build subject_params
    ActiveRecord::Base.transaction do
      @subject.save!
      assign_subject
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
    if @subject.update_attributes subject_params
      flash[:success] = t ".success"
      redirect_to supervisor_course_path @course
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
    redirect_to supervisor_course_path @course
  end

  def finish
    @subject = Subject.find_by_id params[:subject_id]
    if @subject.update_attributes status: :finish
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to supervisor_course_path @course
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description, :start_time,
      :end_time, :status
  end

  def assign_subject
    UserCourse.trainees_on_course(@course.id).each do |user|
      TraineeSubject.bulk_insert(ignore: true) do |worker_subject|
        worker_subject.add(trainee_id: user.user_id,
        subject_id: @subject.id, course_id: @course.id)
      end
    end
  end

  def find_subject
    @subject = Subject.find_by_id params[:id]
    return if @subject
    flash[:error] = t ".not_found"
    redirect_to supervisor_course_path @course
  end

  def find_course
    @course = Course.find_by_id params[:course_id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end
end
