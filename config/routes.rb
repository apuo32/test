Rails.application.routes.draw do
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
  root "admin/departments#index"
end
