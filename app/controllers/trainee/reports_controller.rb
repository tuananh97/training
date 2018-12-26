class Trainee::ReportsController < Trainee::BaseController
  def index
    @list_reports = Report.trainee_reports(current_user.id)
                          .page(params[:page]).per Settings.per_page
  end

  def new
    @trainers = User.load_data.supervisor
    @sum_trainers = @trainers.length
    @report = Report.new
  end

  def create
    @report = Report.new report_params
    if !params[:receiver_ids].nil?
      @report.save
      TraineeReport.bulk_insert(ignore: true) do |worker|
        params[:receiver_ids].each do |receiver_id|
          worker.add(receiver_id: receiver_id, report_id: @report.id)
        end
      end
      flash[:success] = t ".success"
      redirect_to trainee_reports_url
    else
      flash[:error] = t ".failure"
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit :title, :description, :sender_id
  end
end
