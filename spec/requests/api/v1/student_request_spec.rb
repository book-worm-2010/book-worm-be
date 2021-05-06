require 'rails_helper'

describe 'Students API' do
  describe 'student books' do
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

      found_books[:data].each do |student_book|
        expect(student_book).to have_key(:id)
        expect(student_book[:id]).to be_a(String)

        expect(student_book[:attributes]).to have_key(:student_id)
        expect(student_book[:attributes][:student_id]).to be_a(Integer)

        expect(student_book[:attributes]).to have_key(:book_id)
        expect(student_book[:attributes][:book_id]).to be_a(Integer)

        expect(student_book[:attributes]).to have_key(:status)
        expect(student_book[:attributes][:status]).to be_a(String)
      end

      found_books[:included].each do |book|
        expect(book).to have_key(:id)
        expect(book[:id]).to be_a(String)

        expect(book[:attributes]).to have_key(:title)
        expect(book[:attributes][:title]).to be_a(String)

        expect(book[:attributes]).to have_key(:author)
        expect(book[:attributes][:author]).to be_a(String)

        expect(book[:attributes]).to have_key(:isbn)
        expect(book[:attributes][:isbn]).to be_a(String)

        expect(book[:attributes]).to have_key(:pages)
        expect(book[:attributes][:pages]).to be_a(Integer)

        expect(book[:attributes]).to have_key(:image)
        expect(book[:attributes][:image]).to be_a(String)
      end
    end

    it 'sends a list of books with finished status' do
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
        "status": 'finished'
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(2)
    end

    it 'sends a list of books with abandoned status' do
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
        "status": 'abandoned'
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(0)
    end

    it 'sends a list of books without status' do
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
        "id": student.id
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(5)
    end

    it 'sends an empty data array if status is not an option' do
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
        "status": 'this is not an option'
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(0)
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
        "student_id": student.id,
        "book_id": book.id
      }

      get bookmarks_api_v1_students_path, params: data
      expect(response).to be_successful
      found_bookmarks = JSON.parse(response.body, symbolize_names: true)
      expect(found_bookmarks[:data].count).to eq(2)

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

  describe 'login' do
    it 'returns current student information' do
      student = create(:student)
      params = {
        "email": student.email,
        "name": student.name
      }

      get login_api_v1_students_path, params: params

      expect(response).to be_successful
      found_student = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(found_student[:id]).to eq(student.id.to_s)
      expect(found_student[:attributes][:name]).to eq(student.name)
      expect(found_student[:attributes][:email]).to eq(student.email)
    end

    it 'returns new student information' do
      params = {
        "email": 'anewemail@email.com',
        "name": 'Student Name'
      }

      get login_api_v1_students_path, params: params

      expect(response).to be_successful
      new_student = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(new_student).to have_key(:id)
      expect(new_student[:attributes][:name]).to eq('Student Name')
      expect(new_student[:attributes][:email]).to eq('anewemail@email.com')
    end

    it 'gives an error if all fields are not given' do
      params = {
        "email": 'anewemail@email.com'
      }

      get login_api_v1_students_path, params: params
      expect(response).to_not be_successful
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:error]).to eq('please include both email and name')
    end
  end
end
