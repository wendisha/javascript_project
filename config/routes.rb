Rails.application.routes.draw do

  root 'sessions#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'


  resources :users, only: [:new, :create, :show] do
    resources :contracts
    resources :agents
    resources :clubs
    resources :futbolistas
  end

end
