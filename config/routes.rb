Rails.application.routes.draw do
  resources :tasks do
    member do
      patch 'done'
      patch 'undo'
    end
  end
  get 'calendar', to: 'tasks#calendar'
  get 'week', to: 'tasks#week'
  get 'day', to: 'tasks#day'
  devise_for :users

  root to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
