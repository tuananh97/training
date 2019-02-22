class CoursesController < ApplicationController
  before_action :find_course, only: :show

   def index
    @q = Course.ransack params[:q]
    @courses = @q.result(distinct: true).page(params[:page]).per 4
  end

   def show
    @user_course = UserCourse.new
  end

   def find_course
    @course = Course.find_by_id params[:id]
    return if @course
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
