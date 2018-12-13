class Supervisor::ReportsController < Supervisor::BaseController
  def index
    @list_reports = Report.trainer_reports current_user.id
  end
end
