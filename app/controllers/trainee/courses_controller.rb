class Trainee::CoursesController < Trainee::BaseController
  before_action :find_course, only: [:show, :show_member]

   def index
    @my_courses = Course.trainee_courses(current_user.id).page(params[:page]).per Settings.per_page
   end

   def show; end

   def show_member
     @member = @course.users.order(role: :desc).page(params[:page]).per Settings.per_page
   end

   private

   def find_course
    @course = Course.find_by_id params[:id]

    return if @course
    flash[:danger] = t ".not_found"
    redirect_to root_path
   end
end
