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
  end
end
