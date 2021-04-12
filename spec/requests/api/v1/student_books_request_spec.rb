require 'rails_helper'

describe 'StudentBooks API' do
  describe 'dashboard' do
    it 'creates a new relationship' do
      student = create(:student)
      different_book = create(:book)
      book = Book.create(title: "Harry Potter and the Sorcerers Stone",
                         author: "J.K. Rowling",
                         pages: 345)
      data =
       {
         student_id: student.id,
         book: {
           title: "Harry Potter and the Sorcerers Stone",
           author: "J.K. Rowling",
           pages: 345
         }
      }

      #get api/v1/student_books
      post api_v1_student_books_path, params: data

      expect(response).to be_successful
      new_book = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(new_book[:attributes][:student_id]).to eq(student.id)
      expect(new_book[:attributes][:book_id]).to eq(book.id)
      expect(new_book[:attributes][:book_id]).to_not eq(different_book.id)
      expect(new_book[:attributes][:status]).to eq(nil)
    end

    it "updates a student book" do
      student = create(:student)
      book = create(:book)
      student_book = StudentBook.create!(student_id: student.id, book_id: book.id)

      data = {
        "student_id": student.id,
        "book_id": book.id,
        "status": "finished",
        "review": "4",
        "reivew_comment": "A pretty good book, but I didn't like the ending."
      }

      patch api_v1_student_book_path({ id: student_book.id}), params: data

      expect(response).to be_successful
      updated_student_book = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(updated_student_book[:attributes][:student_id]).to eq(student.id)
      expect(updated_student_book[:attributes][:book_id]).to eq(book.id)
      expect(updated_student_book[:attributes][:status]).to eq('finished')
      expect(updated_student_book[:attributes][:review]).to eq(4)
      expect(updated_student_book[:attributes][:reivew_comment]).to eq("A pretty good book, but I didn't like the ending.")
    end

    it "throws an error if a student book cannot be found" do
      student = create(:student)
      book = create(:book)
      student_book = StudentBook.create!(student_id: student.id, book_id: book.id)

      data = {
        "student_id": student.id,
        "book_id": book.id,
        "status": "finished",
        "review": "4",
        "reivew_comment": "A pretty good book, but I didn't like the ending."
      }

      patch api_v1_student_book_path({ id: (student_book.id - 1)}), params: data

      expect(response).to_not be_successful
    end

    it "throws an error if not all areas are included" do
      student = create(:student)
      book = create(:book)
      student_book = StudentBook.create!(student_id: student.id, book_id: book.id)

      data = {
        "status": "abandoned",
      }

      patch api_v1_student_book_path({ id: (student_book.id - 1)}), params: data

      expect(response).to_not be_successful
    end
  end
end
