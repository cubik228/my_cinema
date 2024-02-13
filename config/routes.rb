Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :movies do
    get 'actors', on: :member
    get 'producers', on: :member
    get 'report_to_excel', on: :collection
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
