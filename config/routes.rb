Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    resources :tasks do
      resources :comments
    end
  end
  resources :sessions
  post 'tasks/:task_id/edit', to: 'tasks#change_status'
end
