Rails.application.routes.draw do

  root 'sessions#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create'
  get '/users/:user_id/trophy' => 'users#trophy', as: :trophy

  resources :users, only: [:new, :create, :show] do
    resources :contracts
    resources :agents
    resources :clubs
    resources :players
  end

end
