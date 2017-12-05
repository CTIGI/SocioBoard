require 'sidekiq/web'
require 'sidetiq/web'

Rails.application.routes.draw do
  devise_for :users

  resources :offenders do
    collection do
      get :modal_index
      get :generate_pdf
      get :generate_sheet
    end
  end

  resources :dashboard

  resources :analysis, only: [:update] do
    collection do
      get :unconformities, as: :unconformities
      get :simulator, as: :simulator
      get :load_simulator_modal, :load_simulator_modal
      get :update_table
      get :reload_simulation
    end
  end

  resources :simulations do
    collection do
      post :new_simulation
    end
  end

  resources :indicators, only: [] do
    collection do
      get :indicator_01, as: :indicator_01
      get :units, as: :units
      get :unit_profile
    end
  end

  resources :maps, only: [:index] do
  end

  resources :roles
  resources :users
  resources :units, only: [:index, :edit, :update, :show]

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root "home#index"
end
