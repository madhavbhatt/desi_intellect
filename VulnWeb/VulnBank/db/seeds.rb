User.create!(name: "Admin Test", email: "admin@test.com", password: "testing", password_confirmation: "testing", admin: true)

User.create!(name: "Testing", email: "testing@test.com", password: "testing", password_confirmation: "testing")

99.times do |n|
	name = Faker::Name.name[7..20]
	email = "example-#{n+1}@fakers.org"
	password = "password"
	User.create!(name: name, email: email, password: password, password_confirmation: password)
end