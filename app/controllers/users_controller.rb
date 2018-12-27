class UsersController < HomePagesController
  before_action :load_user, only: %i(show edit)

  def show
    @my_courses = @user.courses.page(params[:page]).per Settings.user.per_page
  end

  def edit; end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:error] = t ".not_found_user"
    redirect_to home_path
  end
end
