require "csv"

namespace :create_question do
  task question_data: :environment do
    puts "Create questions"
    CSV.foreach(Rails.root.join("lib", "tasks", "csv", "questions.csv"),
      headers: true) do |row|
      Question.create! do |q|
        q.exam_id = row[0]
        q.content = row[1]
      end
    end
  end
end

namespace :create_answers do
  task answers_data: :environment do
    puts "Create answers"
    CSV.foreach(Rails.root.join("lib", "tasks", "csv", "answers.csv"),
      headers: true) do |row|
      Answer.create! do |answer|
        answer.question_id = row[0]
        answer.content = row[1]
        answer.is_correct = row[2]
      end
    end
  end
end
