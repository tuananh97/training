class Question < ApplicationRecord
  enum question_type: %i(single_choice multiple_choice)

  belongs_to :exam
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :tests, through: :results, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, presence: true
end
