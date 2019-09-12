Rails.application.routes.draw do
  resources :customers, except: [:create, :new, :destroy] do
    post :do_white, on: :member
    post :do_black, on: :member
  end

  root to: 'customers#index'

  get 'blacklist', to: 'customers#blacklist'
  get '/search', to: 'customers#search'
end
