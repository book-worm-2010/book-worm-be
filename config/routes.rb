Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :books do 
        get 'find_all', on: :collection
      end
    end
  end


end
