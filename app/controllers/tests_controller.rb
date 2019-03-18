class TestsController < HomePagesController
  def index
    @tests = current_user.tests.page(params[:page]).per Settings.per_page_index
  end

  def create
    @test = current_user.tests.build test_params
    if @test.save
      question_create
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to user_test_path current_user, @test
  end

  def show
    @test = Test.find_by_id params[:id]
    @questions = @test.questions.includes(:answers).page(params[:page]).per 3
  end

  def update
    @test = Test.find_by_id params[:id]
    @test.update_attributes test_params
    if @test.correct_answer_of_test != 0
      @test.update score: (10*@test.correct_answer_of_user.to_f/@test.correct_answer_of_test).round(2)
    end
    flash[:success] = t ".submit"
    redirect_to user_test_path @test
  end

  private

  def test_params
    params.require(:test).permit :user_id, :exam_id, :status, :date, :score,
      results_attributes: %i(id question_id answer_id)
  end

  def question_create
    @test_questions = @test.exam.questions.order("RAND()").limit(@test.exam.number_question)
    @test_questions.each do |question|
      @test.results.create question_id: question.id
    end
  end
end
