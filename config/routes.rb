Rails.application.routes.draw do
  get 'person_industries/person_technologies'
  get 'person_industries/person_expertises'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :persons,             only: [:new, :create, :destroy, :index, :show]
  resources :person_technologies, only: [:new, :create]
  resources :person_expertises,   only: [:new, :create]
  resources :person_industries,   only: [:new, :create]
end
