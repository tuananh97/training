module UserCoursesHelper
  def create_course
    current_user.active_admin_courses.build
  end
end
