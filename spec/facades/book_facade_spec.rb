require 'rails_helper'

describe BookFacade do 
  describe "book info", :vcr do 
    it "it create poros of book info through google books api" do 
      params = {title: "Harry Potter and the Sorcerer's Stone",
              author: "J. K. Rowling"}
      books = BookFacade.book_info(params)
      
      books.each do |book|
        expect(book.title).to be_a(String)
        expect(book.author).to be_a(String)
        expect(book.pages).to be_a(Numeric)
        expect(book.image).to be_a(String)
        expect(book.isbn).to be_a(String)
      end
    end
  end
end