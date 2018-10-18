namespace :sample_data do
  task create: :environment do
    puts "Create Users"
    User.bulk_insert do |user|
      supervisor = 0
      trainee = 1
      password = "123456"
      20.times do
        user.add(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          phone: Faker::PhoneNumber.phone_number.gsub(/\s/, ""),
          address: Faker::Address.street_address,
          role: supervisor,
          password: password,
          encrypted_password: BCrypt::Password.create(password))
      end
      20.times do
        user.add(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          phone: Faker::PhoneNumber.phone_number.gsub(/\s/, ""),
          address: Faker::Address.street_address,
          role: trainee,
          password: password,
          encrypted_password: BCrypt::Password.create(password))
      end
    end
  end
end
