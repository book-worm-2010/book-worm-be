# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


student = Student.create!(name: 'Example Student', email: 'example@gmail.com')
books = FactoryBot.create_list(:book, 3)
books.each do |book|
  StudentBook.create!(student_id: student.id, book_id: book.id)
end
