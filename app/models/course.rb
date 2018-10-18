class Course < ApplicationRecord
  has_many :subjects, dependent: :destroy
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :having_user, through: :user_courses, source: :user
  has_many :passive_admin_courses, class_name: UserCourse.name,
           foreign_key: :course_id, dependent: :destroy
  has_many :be_admins, through: :passive_admin_courses, source: :be_admin

  validates_datetime :end_time, after: :start_time, message: I18n.t(".validate_time")

  enum status: {init: 0, start: 1, finish: 2}

  accepts_nested_attributes_for :subjects, allow_destroy: true
  scope :all_courses, ->{select(:id, :name, :description, :status, :start_time, :end_time).order created_at: :desc}

  scope :trainee_courses, ->(id){joins(:user_courses).select(:id, :name, :description, :start_time, :end_time, :status, "user_courses.user_id as user_id, user_courses.course_id as course_id").where(user_courses: {user_id: id, status: [:trainee_start, :trainee_complete]})}

  def assign_user user
    if user.supervisor?
      user_courses.create user_id: user.id
    else
      user_courses.create user_id: user.id, status: :trainee_start
    end
  end

  def remove_user user
    having_user.delete user
  end
end
