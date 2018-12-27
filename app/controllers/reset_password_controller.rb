class ResetPasswordController < HomePagesController
  before_action :authenticate_user!, except: %i(edit update)

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_with_password user_params
      sign_in :user, @user, bypass: true
      flash[:success] = t ".change_password_success"
      redirect_to home_path
    else
      flash[:error] = t ".change_password_failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :current_password, :password,
      :password_confirmation
  end
end
