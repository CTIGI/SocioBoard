Rails.application.routes.draw do
  resources :offenders
  resources :dashboard

  root "offenders#index"
end
