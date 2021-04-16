Rails.application.routes.draw do
  resources :web_push_notifications
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
      resources :subscriptions, only: :create
      resources :student_books, only: %i[create update]
      resources :bookmarks, only: :create
    end
  end
end
