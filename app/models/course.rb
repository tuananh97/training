class Course < ApplicationRecord
  has_one :image, as: :imageable, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :user_courses
  has_many :users, through: :user_courses
  has_many :having_user, through: :user_courses, source: :user
  has_many :passive_admin_courses, class_name: UserCourse.name,
           foreign_key: :course_id, dependent: :destroy
  has_many :be_admins, through: :passive_admin_courses, source: :be_admin

  enum status: {init: 0, start: 1, finish: 2}
  validates_datetime :end_time, after: :start_time, message: I18n.t(".validate_time")

  accepts_nested_attributes_for :subjects, allow_destroy: true

  accepts_nested_attributes_for :image, reject_if: proc {|attributes|
    attributes['image_url'].blank?}

  attr_select = %i(id name description status start_time end_time)
  scope :by_lastest, ->{select(attr_select).order(created_at: :desc)}

  scope :trainee_courses, lambda{|id|
    joins(:user_courses).select(:id, :name, :description, :start_time,
      :end_time, :status, "user_courses.user_id as user_id,
      user_courses.course_id as course_id").where(user_courses:
      {user_id: id, status: [:trainee_start, :trainee_complete]})
  }

  def assign_user user
    user_courses.create user_id: user.id, status: :trainee_start
  end

  def remove_user user
    having_user.delete user
  end
end
