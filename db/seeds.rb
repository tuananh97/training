20.times do |i|
        User.create!
          name: Faker::Name.name,
          email: "admin_#{i}@email.com",
          phone: "097659430#{i}",
          address: Faker::Address.street_address,
          role: 1,
          password: "123456",
          encrypted_password: BCrypt::Password.create("123456")
end
20.times do |j|
         User.create!
          name: Faker::Name.name,
          email: "user_#{j}@email.com",
          phone: "097659420#{j}",
          address: Faker::Address.street_address,
          role: 0,
          password: "123456",
          encrypted_password: BCrypt::Password.create(password"123456")
end
