namespace :create_course do
  task course_data: :environment do
    puts "Create courses"
    Course.bulk_insert do |course|
      10.times do |i|
        course.add(
          name: "Course demo #{i}",
          description: "Description course demo #{i}",
          start_time: 10.days.ago,
          end_time: 2.days.ago
        )
      end
    end
  end
end
