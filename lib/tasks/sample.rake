namespace :sample_data do
  task create: :environment do
    puts "Create Users"
    User.bulk_insert do |user|
      supervisor = 1
      trainee = 0
      password = "123456"
      20.times do |i|
        user.add(
          name: Faker::Name.name,
          email: "admin_#{i}@email.com",
          phone: Faker::PhoneNumber.phone_number.gsub(/\s/, ""),
          address: Faker::Address.street_address,
          role: supervisor,
          password: password,
          encrypted_password: BCrypt::Password.create(password))
      end
      20.times do |j|
        user.add(
          name: Faker::Name.name,
          email: "user_#{j}@email.com",
          phone: Faker::PhoneNumber.phone_number.gsub(/\s/, ""),
          address: Faker::Address.street_address,
          role: trainee,
          password: password,
          encrypted_password: BCrypt::Password.create(password))
      end
    end

    puts "Create courses"
    Course.bulk_insert do |course|
      10.times do |i|
        course.add(
          name: "Course #{i}",
          description: "description #{i}",
          start_time: 30.days.ago,
          end_time: 10.days.ago)
      end
    end

    puts "Create supervisor course"
    UserCourse.bulk_insert do |user_course|
      Course.all.each do |course|
        user_course.add(
          user_id: rand(1..20),
          course_id: course.id,
          status: 0)
      end
    end

    puts "Create subjects for course"
    Subject.bulk_insert do |subject|
      Course.all.each_with_index do |course, index|
        subject.add(
          name: "subject #{index}",
          description: "description subject #{index}",
          course_id: course.id,
          start_time: 20.days.ago,
          end_time: 10.days.ago,
          status: 0)
      end
    end

    puts "Create tasks for subject"
    Task.bulk_insert do |task|
      Subject.all.each_with_index do |subject, index|
        task.add(
          name: "task #{index}",
          description: "description task #{index}",
          content: "Content #{index}",
          subject_id: subject.id)
      end
    end
  end
end
