class UserCourse < ApplicationRecord
  enum status: {admin: 0, trainee_start: 1, trainee_complete: 2}
  belongs_to :user
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
end
