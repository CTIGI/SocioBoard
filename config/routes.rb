Rails.application.routes.draw do
  resources :offenders do
    collection do
      get :modal_index
      get :generate_pdf
      get :generate_sheet
    end
  end
  resources :dashboard
  resources :analysis, only: [] do
    collection do
      get :unconformities, as: :unconformities
    end
  end

  resources :indicators, only: [] do
    collection do
      get :indicator_01, as: :indicator_01
      get :units, as: :units
    end
  end

  resources :roles
  resources :users, only: [:index, :edit, :update, :show]
  resources :units, only: [:index, :edit, :update, :show]

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: 'users/sessions' }

  devise_scope :user do
    get "destroy", :to => "users/sessions#destroy", :as => :destroy_user_session
  end

  root "home#index"
end
