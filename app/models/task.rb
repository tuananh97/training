class Task < ApplicationRecord
  mount_uploader :video, VideoUploader

  has_many :trainee_tasks, dependent: :destroy
  belongs_to :subject
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :content, presence: true

  scope :task_not_assign_trainee, lambda{
    left_outer_joins(:trainee_tasks)
      .select("tasks.id as task_id_new, trainee_tasks.task_id")
      .where("trainee_tasks.task_id is null")
  }
end
