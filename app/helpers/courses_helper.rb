module CoursesHelper
  def load_user_form course, user
    @user_course = course.user_courses.find_by user_id: user.id
    return false if @user_course
  end
end
