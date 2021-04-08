FactoryBot.define do
  factory :student, class: Student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
