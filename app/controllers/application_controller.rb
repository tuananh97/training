class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper :all

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_supervisor
    return if current_user.supervisor?
    flash[:danger] = t ".not_permission"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation, :remember_me, :address, :avatar]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
