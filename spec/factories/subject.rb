FactoryBot.define do
  factory :subject do
    name {Faker::Book.title}
    description {Faker::Lorem.sentence(300)}
    start_time {Time.zone.now}
    end_time {3.day.from_now}
  end
end
