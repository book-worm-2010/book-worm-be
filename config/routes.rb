Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')
  namespace :api do
    namespace :v1 do
      resources :books do
        get 'find_all', on: :collection
        post 'create', on: :collection
      end
      resources :students do
        get 'books', on: :collection
        get 'bookmarks', on: :collection
      end
      resources :student_books, only: %i[create update]
      resources :bookmarks, only: :create
      post '/token', to: 'tokens#create'
    end
  end
end
