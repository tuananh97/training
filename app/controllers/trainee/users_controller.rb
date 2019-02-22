class Trainee::UsersController < Trainee::BaseController
  before_action :find_user, only: :show

  def show
    @my_courses = @user.courses.page(params[:page]).per Settings.user.per_page
  end

  private

  def find_user
    @user = User.find_by_id params[:id]
    return if @user&.trainee?
    flash[:error] = t ".message.not_found_member"
    redirect_to root_path
  end
end
