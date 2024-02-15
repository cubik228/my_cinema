Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :movies do
    member do
      get 'actors'
      get 'producers'
    end
    collection do
      get 'report_to_excel'
      get 'rating', to: 'movies#rating'
    end
  end
  
  resources :actors do 
    get 'report_to_excel', on: :collection
  end
  resources :producers do 
    get 'report_to_excel', on: :collection
  end
  resources :categories do 
    get 'report_to_excel', on: :collection
  end

  get '/actors/:id/movies', to: 'actors#movies'
  get '/producers/:id/movies', to: 'producers#movies'
end
