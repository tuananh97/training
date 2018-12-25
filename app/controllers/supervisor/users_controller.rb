class Supervisor::UsersController < Supervisor::BaseController
  before_action :load_user, only: %i(edit update destroy)
  before_action :find_supervisor, only: :show

  def index
    @users = User.trainee.by_lastest.page(params[:page]).per Settings.user.per_page_index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".add_success", name: @user.name
      redirect_to supervisor_trainee_path
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def show
    @courses = @user.courses.page(params[:page]).per Settings.per_page
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to supervisor_users_path
    else
      flash[:error] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".warning"
    end
    redirect_to supervisor_users_path
  end

  def all_supervisors
    @supervisors = User.load_data.supervisor.page(params[:page]).per Settings.user.per_page
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t ".not_found"
    redirect_to supervisor_users_path
  end

  def find_supervisor
    @user = User.find_by_id params[:id]
    if @user&.supervisor?
      return @user
    else
      flash[:error] = t ".not_found_supervisor"
      redirect_to root_path
    end
  end
end
