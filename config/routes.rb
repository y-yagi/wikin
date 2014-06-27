Rails.application.routes.draw do
  root 'index#index'

  get 'admin/dump'
  get 'search/index'
  resources :pages do
    get :titles, on: :collection
  end
  get '*path', to: 'pages#show', constraints: Constraints::PathConstraint.new
end
