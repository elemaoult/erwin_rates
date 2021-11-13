Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # get 'freelancer_industries/freelancer_technologies'
  # get 'freelancer_industries/freelancer_expertises'

    root to: 'pages#home'
    post "freelancer_expertises_data", to: "freelancers#freelancer_expertises_data"
    get "request",         to: 'pages#request',                   as: 'request'
    get "search", to: 'pages#search', as: "search"
    get "confidentialite", to: 'pages#persospecs', as: 'persospecs'
    get "mentionslegales", to: 'pages#legalspecs', as: 'legalspecs'
    get "cgu", to: 'pages#cgu', as: 'cgu'

    #get "gestiondescookies", to: 'pages#cookiesspecs', as: 'cookiesspecs'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :freelancers,             only: [:new, :create, :destroy, :index, :show]
  resources :freelancer_technologies, only: [:new, :create]
  resources :freelancer_expertises,   only: [:new, :create]
  resources :freelancer_industries,   only: [:new, :create]
  resources :users do
    resources :reviews, only: [:new, :create, :show]
  end

  resources :donations, only: [:new, :index, :show, :create] do
    resources :payments, only: :new
  end

    #root to: 'pages#users'
    #get '/users/:id',      to: 'users#show',                       as: 'user'

    #get "donations", to: './donations/new', as: 'donation'

    

  # post 'filter', to: 'freelancers#filter'

  #adding special routes to use blazer - no admin privilege require
  mount Blazer::Engine, at: "blazer"
  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
