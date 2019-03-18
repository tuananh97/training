module UsersHelper
  def find_user id
    @user = User.find_by_id id
    return @user if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def role_collection
    roles = []
    User.roles.keys.each do |item|
      roles << [I18n.t("enum.user.role.#{item}"), item]
    end
    roles
  end
end
