class BookService
  class << self
    def call_googlebooks(search_params, author)
      response = conn.get('/books/v1/volumes') do |req|
        req.params['key'] = ENV['GOOGLE_API_KEY']
        req.params['q'] = "intitle:#{search_params}+inauthor:#{author}"
      end
      parse_data(response)
    end

    private

    def conn
      Faraday.new('https://www.googleapis.com')
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
