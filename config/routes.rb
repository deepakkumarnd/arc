Rails.application.routes.draw do
  devise_for :users

  get '/dashboard', to:  'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :text_operations, only: [] do
        collection do
          post :run_commands
        end
      end
    end
  end

  root to: 'home#index'
end
