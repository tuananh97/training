class Task < ApplicationRecord
  has_many :trainee_tasks
  belongs_to :subject
end
