PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get 'register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/about', to: 'pages#about'
  
  resources :posts, except: [:destroy] do
    member do
      post :vote
    end
    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end
  resources :users, except: [:destroy]
  resources :categories, only: [:new, :create, :show]
end
