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
      post :archive
    end
  end

  resources :archived_pages, only: [:index, :show, :destroy] do
    member do
      post :restore
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  get '*path', to: 'pages#show', constraints: PathConstraint.new
end
