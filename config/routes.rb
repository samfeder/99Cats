Rails.application.routes.draw do
  resources :cats
  resources :rental_requests do
    member do
      post 'approve'
    end
    member do
      post 'deny'
    end
  end

  resources :users

  resource :session
end
