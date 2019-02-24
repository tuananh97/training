class TestsController < HomePagesController

  def index
    @tests = current_user.tests
  end

  def create
    @test = current_user.tests.build test_params
    if @test.save
      question_create
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to user_tests_path current_user
  end

  def show
    @test = Test.find_by_id params[:id]
  end

  def update
    @test = Test.find_by_id params[:id]
    @test.update_attributes test_params
    if @test.correct_answer_of_test != 0
      @test.update score: 10*@test.correct_answer_of_user/@test.correct_answer_of_test
    end
    flash[:success] = t ".submit"
    redirect_to user_tests_path current_user
  end

  private

  def test_params
    params.require(:test).permit :user_id, :exam_id, :status, :date, :score,
      results_attributes: %i(id question_id answer_id)
  end

  def question_create
    @test_questions = @test.exam.questions.limit(5)
    @test_questions.each do |question|
      @test.results.create question_id: question.id
    end
  end
end
