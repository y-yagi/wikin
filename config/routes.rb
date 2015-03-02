Rails.application.routes.draw do
  root 'index#index'

  get 'admin/dump'
  resources :pages do
    collection do
      get :titles
      get :search
      post :preview
    end

    member do
      get :restore
      get :undo
    end
  end

  get '*path', to: 'pages#show', constraints: PathConstraint.new
end
