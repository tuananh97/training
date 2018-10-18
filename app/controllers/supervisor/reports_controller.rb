class Supervisor::ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @list_reports = Report.trainer_reports current_user.id
  end
end
