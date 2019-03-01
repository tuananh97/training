class Supervisor::QuestionsController < Supervisor::BaseController
  before_action :find_exam, expect: :destroy
  before_action :find_question, only: %i(edit update destroy show)

  def index
    @questions = @exam.questions
  end

  def show
    @answers = @question.answers
    respond_to do |format|
      format.js
    end
  end

  def new
    @question = Question.new
    4.times do
      @question.answers.build
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    @question = @exam.questions.build question_params
    if @question.save
      flash[:success] = t ".success"
      redirect_to supervisor_exam_path(@exam)
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t ".success"
      redirect_to supervisor_exam_path(@exam)
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to supervisor_exam_path(@exam)
  end

  private

  def find_question
    @question = Question.find_by_id params[:id]
    return if @question
    flash[:error] = t ".not_found"
    redirect_to supervisor_exam_path(@exam)
  end

  def find_exam
    @exam = Exam.find_by_id params[:exam_id]
    return if @exam
    flash[:error] = t ".not_found"
    redirect_to supervisor_exams_path
  end

  def question_params
    params.require(:question).permit :content, :question_type, :exam_id,
      answers_attributes: %i(id content is_correct question_id)
  end
end
