class BookPoro
  attr_reader :title, :author, :pages, :description, :maturityRating, :image
  def initialize(data)
    @title = data[:title]
    @author = data[:authors].to_sentence
    @pages = data[:pageCount]
    @description = data[:description]
    @maturityRating = data[:maturityRating]
    @image = data[:imageLinks][:thumbnail]
  end
end