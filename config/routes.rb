Rails.application.routes.draw do
  resource :session, only: [:create, :destroy, :new, :show]
  resources :users, only: [:create, :new]
  resources :bands, only: [:index, :create, :new]

  root to: redirect("/session/new")
end
