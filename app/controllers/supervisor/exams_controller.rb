class Supervisor::ExamsController < Supervisor::BaseController
  before_action :find_exam, only: [:edit, :update, :destroy, :show]

  def index
    @exams = Exam.all
  end

  def show
    @questions = @exam.questions
    @test = current_user.tests.new(exam_id: params[:id])
  end

  def new
    @exam = Exam.new
  end

  def edit; end

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t ".success"
      redirect_to supervisor_exams_path
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t ".success"
      redirect_to supervisor_exams_path
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @exam.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t "..failed"
    end
    redirect_to supervisor_exams_path
  end

  private

  def exam_params
    params.require(:exam).permit :title
  end

  def find_exam
    @exam = Exam.find_by_id params[:id]
    return if @exam
    flash[:error] = t ".not_found"
    redirect_to supervisor_exams_path
  end
end
