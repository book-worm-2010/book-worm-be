class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :author, :isbn, :pages
  set_id {nil}
end
