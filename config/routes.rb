Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"

  resources :homes,    only: [:index]
  resources :medicals, only: [:index]
  resources :centers,  only: [:index]
  resources :experts,  only: [:index]
  resources :sciences, only: [:index]
  resources :news,     only: [:index]
  resources :kepus,    only: [:index]
end
