class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper :all

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation, :remember_me, :address, :avatar]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
