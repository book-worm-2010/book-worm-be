require 'rails_helper'

describe 'Students API' do
  describe 'dashboard' do
    it 'sends a list of books' do
      books = create_list(:book, 3)
      finished_books = create_list(:book, 2)
      student = create(:student)
      books.each do |book|
        StudentBook.create!(book_id: book.id, student_id: student.id, status: 'reading')
      end
      finished_books.each do |book|
        StudentBook.create!(book_id: book.id, student_id: student.id, status: 'finished')
      end

      data = {
        "id": student.id,
        "status": 'reading'
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(3)

      found_books[:data].each do |book|
        expect(book).to have_key(:id)
        expect(book[:id]).to be_an(String)

        expect(book[:attributes]).to have_key(:title)
        expect(book[:attributes][:title]).to be_a(String)

        expect(book[:attributes]).to have_key(:author)
        expect(book[:attributes][:author]).to be_a(String)

        expect(book[:attributes]).to have_key(:pages)
        expect(book[:attributes][:pages]).to be_a(Numeric)
      end
    end

    it 'sends a list of bookmarks' do
      book = create(:book)
      student = create(:student)
      student_book = StudentBook.create!(student_id: student.id, book_id: book.id)
      Bookmark.create!(student_book_id: student_book.id, date: Date.today, minutes: 45, page_number: 42)
      Bookmark.create!(student_book_id: student_book.id, date: Date.today, minutes: 25, page_number: 60)

      book2 = create(:book)
      student_book2 = StudentBook.create!(student_id: student.id, book_id: book2.id)
      Bookmark.create!(student_book_id: student_book2.id, date: Date.today, minutes: 45, page_number: 42)
      Bookmark.create!(student_book_id: student_book2.id, date: Date.today, minutes: 25, page_number: 60)

      data = {
        "id": student.id
      }

      get bookmarks_api_v1_students_path, params: data
      expect(response).to be_successful
      found_bookmarks = JSON.parse(response.body, symbolize_names: true)
      expect(found_bookmarks[:data].count).to eq(4)

      found_bookmarks[:data].each do |bookmark|
        expect(bookmark).to have_key(:id)
        expect(bookmark[:id]).to be_an(String)

        expect(bookmark[:attributes]).to have_key(:date)
        expect(bookmark[:attributes][:date]).to be_a(String)

        expect(bookmark[:attributes]).to have_key(:minutes)
        expect(bookmark[:attributes][:minutes]).to be_a(Numeric)

        expect(bookmark[:attributes]).to have_key(:page_number)
        expect(bookmark[:attributes][:page_number]).to be_a(Numeric)
      end
    end
  end
end
