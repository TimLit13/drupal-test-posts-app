Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'attachments/destroy'
  devise_for :users

  root to: "posts#index"

  resources :posts do
    resources :comments, only: :create
  end

  get 'about', to: 'static_pages#about'
  resources :attachments, only: :destroy
end
