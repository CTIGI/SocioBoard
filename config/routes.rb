Rails.application.routes.draw do
  resources :offenders
  resources :dashboard

  root "main#index"
end
