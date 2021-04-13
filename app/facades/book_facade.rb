class BookFacade
  class << self
    def book_info(params)
      book_info = BookService.call_googlebooks(params[:title], params[:author])
      poro = BookPoro.new(book_info[:items].first[:volumeInfo])
      Book.find_or_create_by(title: poro.title, author: poro.author, pages: poro.pages)
    end
  end
end