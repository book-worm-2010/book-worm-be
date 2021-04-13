FactoryBot.define do 
  factory :book, class: Book do 
    title { Faker::Book.unique.title }
    author { Faker::Book.author }
    pages { Faker::Number.between(from: 50, to: 100)}
    isbn { Faker::Number.unique.number(digits: 13) }
    image { Faker::LoremFlickr.image }
  end
end