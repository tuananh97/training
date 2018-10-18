class Supervisor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_supervisor
  before_action :find_course, except: [:index, :new, :finish]

  def index
    @courses = Course.all_courses.page(params[:page]).per Settings.per_page
  end

  def new
    @course = Course.new
    Settings.course_times.times do
      subject = @course.subjects.build
      Settings.task_times.times do
        subject.tasks.build
      end
    end
  end

  def create
    @course = Course.new course_params

    if @course.save
      @course.passive_admin_courses.create user_id: current_user.id,
        status: :admin
      flash[:success] = t ".success"
      redirect_to supervisor_courses_path
    else
      flash[:danger] = t ".failure"
      render :new
    end
  end

  def show
    @trainees = @course.users.trainee
    @supervisors = @course.users.supervisor
  end

  def edit
    load_all_users
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".success"
      redirect_to supervisor_course_path
    else
      flash[:danger] = t ".failure"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  def finish
    @course = Course.find_by_id params[:course_id]

    if @course.update_attributes status: :finish
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  private

  def load_all_users
    @supervisors = User.supervisor.page(params[:page]).per Settings.pages.per
    @trainees = User.trainee.page(params[:page]).per Settings.pages.per
  end

  def find_course
    @course = Course.find_by_id params[:id]

    return @course
    flash[:danger] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def course_params
    params.require(:course).permit :name, :description, :start_time,
      :end_time, :status, subjects_attributes: [:id, :name, :description,
      :start_time, :end_time, :destroy, tasks_attributes: [:id, :name,
      :description, :content, :destroy]]
  end
end
