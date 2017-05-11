Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"

  resources :homes,    only: [:index,:show]
  resources :medicals, only: [:index,:show]
  resources :centers,  only: [:index,:show]
  resources :experts,  only: [:index,:show]
  resources :sciences, only: [:index,:show]
  resources :news,     only: [:index,:show]
  resources :kepus,    only: [:index,:show]
end
