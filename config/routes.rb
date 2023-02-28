Rails.application.routes.draw do
  get 'attachments/destroy'
  devise_for :users

  root to: "posts#index"

  resources :posts
  get 'about', to: 'static_pages#about'
  resources :attachments, only: :destroy
end
