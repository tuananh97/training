class User < ApplicationRecord
  VALID_PHONE_NUMBER_REGEX = Settings.regex.phone
  mount_uploader :avatar, AvatarUploader
  enum role: {trainee: 0, supervisor: 1, admin: 2}
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable

  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :active_admin_courses, class_name: UserCourse.name,
           foreign_key: :user_id, dependent: :destroy
  has_many :monitoring_courses, through: :active_admin_courses,
           source: :monitoring_course
  has_many :trainee_subjects, foreign_key: :trainee_id, dependent: :destroy
  has_many :trainee_tasks, foreign_key: :trainee_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tests, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.user.user_name.max_length,
             minimum: Settings.user.user_name.min_length}
  validates :phone,
    format: {with: VALID_PHONE_NUMBER_REGEX},
    length: {maximum: Settings.user.phone.max_length,
             minimum: Settings.user.phone.min_length}
  validates :address,
    length: {maximum: Settings.user.address.max_length,
             minimum: Settings.user.address.min_length}
  validates_size_of :avatar, maximum: 5.megabytes,
    message: I18n.t("users.avatar.langer_image")

  attr_select = %i(id name email address phone avatar role)
  scope :load_data, ->{select attr_select}
  scope :by_role, ->{order role: :desc}
  scope :not_admin, ->{where.not(role: 2).order(role: :desc)}

  def send_invite_user_email
    UserMailer.send_invite_instructions(self).deliver
  end

  def get_notifications
    user_courses = self.courses.select(:id)
    Notification.where(course_id: user_courses).order(created_at: :desc)
  end
end
