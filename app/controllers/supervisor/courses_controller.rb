class Supervisor::CoursesController < Supervisor::BaseController
  before_action :find_course, except: %i(index create new finish)

  def index
    @courses = current_user.courses.by_lastest
                           .page(params[:page]).per Settings.per_page_index
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      @course.passive_admin_courses.create user_id: current_user.id,
        status: :admin
      flash[:success] = t ".success"
      redirect_to supervisor_courses_path
    else
      flash[:error] = t ".failure"
      render :new
    end
  end

  def show
    if UserCourse.find_by(user_id: current_user, course_id: @course.id).nil?
      flash[:error] = t ".not_permission"
      redirect_to root_path
    end
    if !@course.nil?
      @subjects = @course.subjects.includes :exams, :tasks
      @trainees = @course.users.trainee
      @supervisors = @course.users.supervisor
    else
      flash[:error] = t ".not_found"
      redirect_to supervisor_courses_path
    end
  end

  def edit
    if UserCourse.find_by(user_id: current_user, course_id: @course.id).nil?
      flash[:error] = t ".not_permission"
      redirect_to root_path
    end
    if !@course.nil?
      load_all_users
    else
      flash[:error] = t ".not_found"
      redirect_to supervisor_courses_path
    end
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".success"
      redirect_to supervisor_courses_path
    else
      flash[:error] = t ".failure"
      load_all_users
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
    end
    redirect_to supervisor_courses_path
  end

  def finish
    @course = Course.find_by_id params[:course_id]
    if @course.update_attributes status: :finish
      flash[:success] = t ".success"
    else
      flash[:error] = t ".failure"
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
    return if @course
    flash[:error] = t ".not_found"
    redirect_to supervisor_courses_path
  end

  def course_params
    params.require(:course).permit :name, :description, :avatar, :start_time,
      :end_time, :status
  end
end
