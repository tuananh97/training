namespace :create_course do
  task course_data: :environment do
    puts "Create courses"
    Course.bulk_insert do |course|
      10.times do |i|
        course.add(
          name: "Course #{i}",
          description: "description #{i}",
          start_time: 30.days.ago,
          end_time: 10.days.ago
        )
      end
    end

    puts "Create supervisor course"
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
