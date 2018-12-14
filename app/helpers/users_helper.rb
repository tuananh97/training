module UsersHelper
  def find_user id
    @user = User.find_by_id id
    return @user if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def page_index params_page, index, per_page
    params_page ||= 1
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end
end
