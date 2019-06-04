Rails.application.routes.draw do
  resources :people do
    collection do
      get :import
      post :import
    end
  end
end
