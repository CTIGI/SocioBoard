Rails.application.routes.draw do
  resources :offenders
  resources :dashboard
  resources :roles
  resources :users, only: [:index, :edit, :update, :show]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
  end

  devise_scope :user do
    get "sign_out", :to => "devise/sessions#destroy", :as => :destroy_user_session
  end

  root "home#index"
end
