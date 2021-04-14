class BookFacade
  class << self
    def book_info(params)
      book_info = BookService.call_googlebooks(params[:title], params[:author])
      book_info[:items].map do |book|
        BookPoro.new(book[:volumeInfo])
      end
      # binding.pry
      # # poro = BookPoro.new(book_info[:items].first[:volumeInfo])
      # check for edge cases before creating
      # send to front end
      # Book.find_or_create_by(title: poro.title, author: poro.author, pages: poro.pages)
    end
  end
end
