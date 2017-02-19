FactoryGirl.define do
  factory :user do
    name 'user'
    email 'user@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end