class Subject < ApplicationRecord
  has_many :trainee_subjects
  belongs_to :course
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
  validates_datetime :end_time, after: :start_time
  enum status: {init: 0, start: 1, finish: 2}
end
