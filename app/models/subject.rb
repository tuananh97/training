class Subject < ApplicationRecord
  enum status: {init: 0, start: 1, finish: 2}

  belongs_to :course
  has_many :tasks, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :trainee_subjects, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates_datetime :end_time, after: :start_time, message: I18n.t(".errors.messages.after")
end
