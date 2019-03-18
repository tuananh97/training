class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: %i(edit update destroy)

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).by_role.page(params[:page])
                                      .per Settings.user.per_page_index
  end

  def new
    @user = User.new
  end

  def create
    password_random = SecureRandom.hex 3
    @user = User.new user_params.merge password: password_random,
      password_confirmation: password_random
    if @user.save
      @user.send_invite_user_email
      flash[:success] = t ".add_success", name: @user.name
      redirect_to admin_users_path
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to admin_users_path
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
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :phone, :avatar, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t ".not_found"
    redirect_to admin_users_path
  end
end
