Rails.application.routes.draw do
  root 'sessions#new'

  post 'sessions/create'
  delete 'sessions/destroy'

  resources :posted_photos, only: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
