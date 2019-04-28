Rails.application.routes.draw do

  root 'sessions#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  resources :agents, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :clubs
  resources :contracts, only: [:show, :new, :create, :edit, :update]
  resources :futbolistas do
    resources :agents, only: [:new]
  end
  resources :users, only: [:new, :create, :show] do
    resources :contracts, only: [:index]
  end

end
