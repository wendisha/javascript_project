Rails.application.routes.draw do

  resources :agents
  resources :clubs
  resources :contracts
  resources :futbolistas do
    resources :agents, only: [:show, :new]
  end
  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:new, :create, :show] do
    resources :contracts, only: [:index]
  end 
end
