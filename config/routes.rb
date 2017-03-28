Rails.application.routes.draw do
  devise_for :users
    resources :stats, except: [:edit,:update,:show] do
        collection do
          get 'analytics'
        end
    end
    resources :users, only: [:show]
  root 'stats#new'
end