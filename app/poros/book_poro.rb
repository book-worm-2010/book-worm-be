class BookPoro
  attr_reader :title, :author, :pages, :description, :maturityRating, :image, :isbn
  def initialize(data)
    @title = data[:title] || "cannot find title"
    @author = data[:authors].to_sentence || "cannot find author"
    @pages = data[:pageCount] || 0
    @description = data[:description] || "cannot find description"
    @maturityRating = data[:maturityRating] || "cannot find raitng"
    @image = images(data[:imageLinks])
    @isbn = isbns(data[:industryIdentifiers])
  end

  def images(data)
    if data
      data[:thumbnail]
    else
      "cannot find images"
    end
  end

  def isbns(data)
    if data
      if data[1]
        data[1][:identifier]
      else
        data.first[:identifier]
      end
    else
      "cannot find isbn"
    end
  end
end