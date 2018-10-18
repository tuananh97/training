class Trainee::ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @list_reports = Report.trainee_reports(current_user.id).page(params[:page]).per Settings.per_page
  end

  def new
    @trainers = User.trainers
    @sum_trainers = User.trainers.length
    @report = Report.new
  end

  def create
    @report = Report.new report_params

    if @report.save
      TraineeReport.bulk_insert(ignore: true) do |worker|
        params[:receiver_ids].each do |receiver_id|
          worker.add({receiver_id: receiver_id, report_id: @report.id})
        end
      end
      flash[:success] = t ".success"
      redirect_to trainee_reports_url
    else
      flash[:danger] = t ".failure"
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit :title, :description, :sender_id
  end
end
