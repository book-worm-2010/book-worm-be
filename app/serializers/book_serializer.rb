class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :author, :isbn, :pages, :image
end
