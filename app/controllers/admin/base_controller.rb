class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  private

  def check_admin
    return if current_user.admin?
    flash[:error] = t ".not_permission"
    redirect_to home_path
  end
end
