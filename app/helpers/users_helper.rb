module UsersHelper
  def find_user id
    @user = User.find_by_id id

    return @user if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
