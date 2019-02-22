namespace :user_enroll_course do
  task enroll_data: :environment do
    puts "Create user_course"
    UserCourse.bulk_insert do |user_course|
      Course.all.each do |course|
        user_course.add(
          user_id: rand(1..20),
          course_id: course.id,
          status: 0
        )
      end
    end
  end
end
