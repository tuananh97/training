namespace :create_supervisor do
  task supervisor_data: :environment do
    puts "Create Supervisors"
    User.bulk_insert do |user|
      password = "123456"
      20.times do |i|
        user.add(
          name: Faker::Name.name,
          email: "admin_#{i}@email.com",
          phone: "0976594#{i}30",
          address: Faker::Address.street_address,
          role: 1,
          password: password,
          encrypted_password: BCrypt::Password.create(password)
        )
      end
    end
  end
end

namespace :create_trainee do
  task trainee_data: :environment do
    puts "Create Trainees"
    User.bulk_insert do |user|
      password = "123456"
      20.times do |j|
        user.add(
          name: Faker::Name.name,
          email: "user_#{j}@email.com",
          phone: "0976594#{j}23",
          address: Faker::Address.street_address,
          role: 0,
          password: password,
          encrypted_password: BCrypt::Password.create(password)
        )
      end
    end
  end
end
