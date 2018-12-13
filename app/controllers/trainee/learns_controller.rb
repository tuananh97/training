class Trainee::LearnsController < Trainee::BaseController
  before_action :find_course, only: :show

  def show; end

  private

  def find_course
    @course = Course.find_by_id params[:id]

    return if @course
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
