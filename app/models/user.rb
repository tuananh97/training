class User < ApplicationRecord
  enum role: {trainee: 0, supervisor: 1}
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
   :validatable
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :trainee_subjects, foreign_key: :trainee_id, dependent: :destroy
  has_many :trainee_tasks, foreign_key: :trainee_id, dependent: :destroy
  has_many :reports
  has_many :active_admin_courses, class_name: UserCourse.name,
           foreign_key: :user_id, dependent: :destroy
  has_many :monitoring_courses, through: :active_admin_courses,
           source: :monitoring_course
  has_many :trainee_reports
  has_many :user_courses
  has_many :courses, through: :user_courses

  scope :by_lastest, ->{order created_at: :desc}
  scope :by_fields, ->{select :id, :name, :email, :address, :phone, :avatar, :role}
  scope :accounts, ->{select :id, :name, :email, :address, :phone}
  scope :members, ->{accounts.trainee}
  scope :trainers, ->{accounts.supervisor}
end
