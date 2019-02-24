class Test < ApplicationRecord
  enum status: %i(waitting done)
  belongs_to :user
  belongs_to :exam

  has_many :results, dependent: :destroy
  has_many :questions, ->{distinct}, through: :results, dependent: :destroy
  has_many :answers, ->{distinct}, through: :results, dependent: :destroy
  has_many :question_answers, ->{distinct}, through: :questions, dependent: :destroy, source: :answers, class_name: Answer.name
  accepts_nested_attributes_for :results

  def answer_ids_of_question question_id
    results.where(question_id: question_id).pluck :answer_id
  end

  def correct_answer_of_user
    answers.where(is_correct: true).count
  end

  def correct_answer_of_test
    question_answers.where(is_correct: true).count
  end
end
