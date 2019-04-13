FactoryBot.define do
  factory :user, class: User do
    name {Faker::Name.name}
    phone {"0943043021"}
    address {"VC HN"}
    email {Faker::Internet.email}
    password {"123123"}
    password_confirmation {"123123"}
  end
end
