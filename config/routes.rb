Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show] do
        get :similar_books, on: :member, action: :find_similar
      end

      resources :authors, only: [:index, :show]
    end
  end
end
