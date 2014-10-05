Rails.application.routes.draw do
  root 'index#index'

  get 'admin/dump'
  resources :pages do
    get :titles, on: :collection
    get :search, on: :collection
    get :restore, on: :member
  end

  get '*path', to: 'pages#show', constraints: Constraints::PathConstraint.new
end
