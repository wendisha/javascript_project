Rails.application.routes.draw do

  resources :agents
  resources :clubs
  resources :contracts
  resources :futbolistas do
    resources :agents, only: [:show, :new]
    resources :contracts, only: [:index]
  end
  resources :sessions, only: [:create, :destroy]

end
