class Supervisor::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_supervisor

  private

  def check_supervisor
    return if current_user.supervisor?
    flash[:danger] = t ".not_permission"
    redirect_to home_path
  end
end
