Rails.application.routes.draw do
  
  root 'pages#index'

  resources :channels do
    member do
      get 'on'
      get 'off'
      get 'status'
    end
  end

end
