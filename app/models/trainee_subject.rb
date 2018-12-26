class TraineeSubject < ApplicationRecord
  belongs_to :user, foreign_key: :trainee_id
  belongs_to :subject
  enum status: {start: 0, inprogress: 1, finish: 2}

  scope :find_trainee_subject, lambda{|user_id, subject_id|
    where trainee_id: user_id, subject_id: subject_id
  }

  scope :trainees_on_subject, lambda{|course_id, subject_id|
    where course_id: course_id, subject_id: subject_id
  }
end
