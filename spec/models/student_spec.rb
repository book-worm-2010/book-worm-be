require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end
  describe 'relationships' do
    it { should have_many(:student_books) }
    it { should have_many(:books).through(:student_books) }
  end
  describe 'instance methods' do
    it 'finds books based on status' do
      books = create_list(:book, 3)
      finished_books = create_list(:book, 2)
      student = create(:student)
      student_books = books.map do |book|
        StudentBook.create!(book_id: book.id, student_id: student.id, status: 'reading')
      end
      student_finished_books = finished_books.map do |book|
        StudentBook.create!(book_id: book.id, student_id: student.id, status: 'finished')
      end
      expect(student.specific_books('reading')).to eq(student_books)
      expect(student.specific_books('finished')).to eq(student_finished_books)
      expect(student.specific_books('abandoned')).to eq([])
    end
  end
end
