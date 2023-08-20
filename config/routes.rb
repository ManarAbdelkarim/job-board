Rails.application.routes.draw do
  resources :job_applications
  resources :job_posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'signup', to: 'users#create', as: 'signup'
  post 'login', to: 'authentication#login'
end
