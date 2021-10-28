Rails.application.routes.draw do
  devise_for :users
  # get 'freelancer_industries/freelancer_technologies'
  # get 'freelancer_industries/freelancer_expertises'

    root to: 'pages#home'

    get "politiquedeconfidentialite", to: 'pages#persospecs', as: 'persospecs'
    get "mentionslegales", to: 'pages#legalspecs', as: 'legalspecs'
    get "conditionsdutilisation", to: 'pages#cgu', as: 'cguspecs'

    #get "gestiondescookies", to: 'pages#cookiesspecs', as: 'cookiesspecs'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :freelancers,             only: [:new, :create, :destroy, :index, :show]
  resources :freelancer_technologies, only: [:new, :create]
  resources :freelancer_expertises,   only: [:new, :create]
  resources :freelancer_industries,   only: [:new, :create]
end
