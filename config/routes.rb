Rails.application.routes.draw do
  devise_for :users
  # get 'freelancer_industries/freelancer_technologies'
  # get 'freelancer_industries/freelancer_expertises'

    root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :freelancers,             only: [:new, :create, :destroy, :index, :show]
  resources :freelancer_technologies, only: [:new, :create]
  resources :freelancer_expertises,   only: [:new, :create]
  resources :freelancer_industries,   only: [:new, :create]
end
