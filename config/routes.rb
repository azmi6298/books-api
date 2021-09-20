Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'books', to: 'books#index'
      get 'books/:id', to: 'books#show'
      get 'books/:id/similar_books', to: 'books#find_similar'
      get 'authors', to: 'authors#index'
      get 'authors/:id', to: 'authors#show'
    end
  end
end
