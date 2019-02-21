namespace :create_subject do
  task subject_data: :environment do
    puts "Create subjects for course"
    Subject.bulk_insert do |subject|
      Course.all.each_with_index do |course, index|
        subject.add(
          name: "Subject demo #{index}",
          description: "Description subject demo #{index}",
          course_id: course.id,
          start_time: 5.days.ago,
          end_time: 2.days.ago,
          status: 0
        )
      end
    end
  end
end

namespace :create_task do
  task task_data: :environment do
    puts "Create tasks for subject"
    Task.bulk_insert do |task|
      Subject.all.each_with_index do |subject, index|
        task.add(
          name: "Task demo #{index}",
          description: "Description task demo #{index}",
          content: "Content of task demo #{index}",
          subject_id: subject.id
        )
      end
    end
  end
end
