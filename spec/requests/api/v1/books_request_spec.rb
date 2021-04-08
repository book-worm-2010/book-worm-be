require 'rails_helper'

describe "Books API" do 
  describe "index" do 
    it "sends a list of books" do 
      create_list(:book, 5)

      get '/api/v1/books'

      expect(response).to be_successful
      books = JSON.parse(response.body, symbolize_names: true)

      expect(books[:data].count).to eq(5)

      books[:data].each do |book|
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

    it "will paginate when list is greater than 20" do 
      create_list(:book, 25)

      get '/api/v1/books'

      expect(response).to be_successful
      books = JSON.parse(response.body, symbolize_names: true)

      expect(books[:data].count).to eq(20)
    end

    describe "show" do 
      it "sends 1 book by title" do 
        book = create(:book)
        expected_attributes = {
          title: book.title,
          author: book.author,
          pages: book.pages
        }

        get "/api/v1/books/#{book.id}"
        expect(response.status).to eq(200)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:id]).to eq(book.id.to_s)
        expected_attributes.each do |attribute, value|
          expect(json[:data][:attributes][attribute]).to eq(value)
        end
      end
    end

    describe "find all" do 
      it "can find all books based on title" do 
        find1 = create(:book, title: "Harry Potter and the Sorcerer's Stone")
        find2 = create(:book, title: "Harry Potter and the Chamber of Secrets")
        cannot_find = create(:book, title: "won't be found")

        expected_attributes1 = {
          title: find1.title,
          author: find1.author,
          pages: find1.pages
        }
  
        expected_attributes2 = {
          title: find2.title,
          author: find2.author,
          pages: find2.pages
        }
  
        get "/api/v1/books/find_all?title=harry"
        
        expect(response.status).to eq(200)
        json = JSON.parse(response.body, symbolize_names: true)
        book1 = json[:data][0]
        book2 = json[:data][1]
        book3 = json[:data][2]
  
        expect(book1[:id]).to eq(find1.id.to_s)
        expected_attributes1.each do |attribute, value|
          expect(book1[:attributes][attribute]).to eq(value)
        end
  
        expect(book2[:id]).to eq(find2.id.to_s)
        expected_attributes2.each do |attribute, value|
          expect(book2[:attributes][attribute]).to eq(value)
        end
        
        expect(book3).to be_nil
      end
    end
  end
end