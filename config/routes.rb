Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies
  resources :seasons do
    resources :episodes
  end
  resources :users do
    get 'library', to: 'users#library'
    resources :purchases
  end
  get 'movies_ordered_by_created_at', to: 'movies#ordered_by_created_at'
  get 'season_with_episodes_ordered', to: 'seasons#seasons_with_episodes_ordered'
  get 'movies_seasons_ordered_by_created_at', to: 'movies_seasons#movies_seasons_ordered_by_created_at'
end
