Rails.application.routes.draw do
  root "shippings#index"
  resources :shippings do
    collection do
      post :validate_step
    end
  end
end
