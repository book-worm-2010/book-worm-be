Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books do
        get 'find_all', on: :collection
      end
      resources :students do
        get 'books', on: :collection
      end
      resources :student_books, only: :create
    end
  end
end
