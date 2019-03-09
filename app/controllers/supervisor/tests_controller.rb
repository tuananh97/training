class Supervisor::TestsController < Supervisor::BaseController
  def show
    @test = Test.find_by_id params[:id]
    @questions = @test.questions.includes :answers
  end
end
