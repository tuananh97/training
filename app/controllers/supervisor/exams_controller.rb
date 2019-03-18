class Supervisor::ExamsController < Supervisor::BaseController
  before_action :find_exam, only: [:edit, :update, :destroy, :show]

  def index
    @exams = Exam.by_lastest.page(params[:page]).per Settings.per_page_index
  end

  def show
    @questions = @exam.questions
    @test = current_user.tests.new(exam_id: params[:id])
  end

  def results
    @exam = Exam.find_by_id params[:exam_id]
    @trainee_on_tests = TraineeSubject.includes(:user).where(subject_id: @exam.subject_id)
  end

  def new
    @subject = Subject.find_by_id params[:subject_id]
    @exam = Exam.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t ".success"
      redirect_to supervisor_exam_path @exam
    else
      flash[:danger] = t ".failed"
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @subject = Subject.find_by_id params[:subject_id]
    respond_to do |format|
      format.js
    end
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t ".success"
      redirect_to supervisor_exam_path @exam
    else
      flash[:danger] = t ".failed"
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @exam.destroy
      @exam.tests.delete_all
      flash[:success] = t ".success"
    else
      flash[:error] = t "..failed"
    end
    redirect_to supervisor_exams_path
  end

  private

  def exam_params
    params.require(:exam).permit :title, :subject_id, :number_question
  end

  def find_exam
    @exam = Exam.find_by_id params[:id]
    return if @exam
    flash[:error] = t ".not_found"
    redirect_to supervisor_exams_path
  end
end
