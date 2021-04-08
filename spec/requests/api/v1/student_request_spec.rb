require 'rails_helper'

describe 'Students API' do
  describe 'dashboard' do
    it 'sends a list of books' do
      books = create_list(:book, 5)
      student = create(:student)
      books.each do |book|
        StudentBook.create!(book_id: book.id, student_id: student.id)
      end

      data = {
        "id": student.id
      }

      get books_api_v1_students_path, params: data
      expect(response).to be_successful
      found_books = JSON.parse(response.body, symbolize_names: true)
      expect(found_books[:data].count).to eq(5)

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
  end
end
