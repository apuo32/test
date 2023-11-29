Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :departments
    resources :evaluators
    resources :users
    resources :tsk_values
    resources :evaluator_progresses
    resources :awards
    resources :calendars
    resources :effect_amounts
  end

  resources :users
  root "users#index"
end
