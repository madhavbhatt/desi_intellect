User.create!(name: "Admin Test", email: "admin@test.com", password: "testing", password_confirmation: "testing", admin: true, master: true)

User.create!(name: "Testing", email: "testing@test.com", password: "testing", password_confirmation: "testing")

User.create!(name: "Testing2", email: "testing2@test.com", password: "testing", password_confirmation: "testing")

Friendship.create!(user_id: "2", friend_id: "3", status: "accepted")
Friendship.create!(user_id: "3", friend_id: "2", status: "accepted")


Account.create!(acct_number: "100000001", status: "active", balance: 1000, owner: "2")

Account.create!(acct_number: "200000002", status: "active", balance: 1000, owner: "3")

99.times do |n|
	name = Faker::Name.name[7..20]
	email = "example-#{n+1}@fakers.org"
	password = "password"
	User.create!(name: name, email: email, password: password, password_confirmation: password)
end