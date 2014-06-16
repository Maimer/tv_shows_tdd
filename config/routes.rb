TvShows::Application.routes.draw do
  resources :television_shows, only: [:index, :show, :new, :create]

  resources :characters, only: [:index]

  resources :television_shows do
    resources :characters, only: [:new, :create]
  end
end
