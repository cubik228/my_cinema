Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :movies do
    get 'actors', on: :member
  end
  
  resources :actors
  resources :producers
  resources :categories 

  get '/actors/:id/movies', to: 'actors#movies'
end
