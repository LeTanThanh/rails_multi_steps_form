Rails.application.routes.draw do
  root "shippings#index"
  resources :shippings
end
