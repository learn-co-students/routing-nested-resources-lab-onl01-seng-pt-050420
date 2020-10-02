Rails.application.routes.draw do
  resources :artists
  resources :artists do
    resources :songs, only: [:index, :show]
  end
  resources :songs
end
