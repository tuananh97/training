class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper :all
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_notifications, if: :user_signed_in?

  protected

  def load_notifications
    @notifications = current_user.notifications.order(:created_at).reverse
  end

  def configure_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation,
      :remember_me, :address, :avatar, :avatar_cache]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
