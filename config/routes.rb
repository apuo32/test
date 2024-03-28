Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :departments
    resources :evaluators
    resources :users
    resources :tsk_values
    resources :evaluator_progresses
    resources :awards
    resources :effect_amounts
    resources :calendars do
      collection do
        post :import
      end
    end
  end

  resources :users
  resources :evaluators
  resources :kaizen_reports
  resources :homes
  
  resources :list_kaizen_reports do
    collection do
      get :export_csv
    end
  end

  resources :submitted_kaizen_reports do
    member do
      patch :return, to: 'submitted_kaizen_reports#return'
    end
    collection do
      post :selected_pdf
    end
  end

  # deviseのRegistrationsController#createへのパスがusers_pathでusers#createと競合するので、パスを変更
  # post 'new_report', to: 'users#create'

  root "users#show"
end
