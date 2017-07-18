Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"

  resources :homes,    only: [:index, :show      ]
  resources :medicals, only: [:index, :show      ]
  resources :centers,  only: [:index, :show      ]
  resources :experts,  only: [:index, :show      ]
  resources :sciences, only: [:index, :show      ]
  resources :news,     only: [:index, :show, :new]
  resources :kepus,    only: [:index, :show      ]

  namespace :exhibition do
    namespace :v1 do
      resources :news,     only: [:index, :show]
    end
  end

  namespace :administration do
    namespace :v1 do
      resources :sessions,   only: [:new]
      resources :dashboards, only: [:show]
      resources :new
      resources :users
    end
  end

  scope '/administration-api/v1', module: 'administration/dosser/v1', as: 'administration_dosser_v1' do
    resources :sessions, only: [:create, :destroy]
    resources :new,      only: [:create, :destroy, :update]
  end

end
