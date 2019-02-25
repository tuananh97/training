class ExamsController < HomePagesController
  before_action :find_exam

  def show; end

  private

  def find_exam
    @exam = Exam.find_by_id params[:id]
    return if @exam
    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
