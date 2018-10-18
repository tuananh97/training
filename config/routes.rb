Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  namespace :trainee do
    resources :users, only: :show
    get "/members", to: "users#all_users"
    get "/courses/:id/members", to: "courses#show_member"
    resources :reports, only: [:index, :new, :create]
    resources :courses, only: [:index, :show]
    resources :learns, only: [:show]
    resources :tasks, only: [:show, :update]
  end
  namespace :supervisor do
    resources :courses do
      resources :subjects do
        patch "/finish", to: "subjects#finish"
      end
      patch "/finish", to: "courses#finish"
    end
    resources :users
    resources :reports, only: :index
    get "/supervisors", to: "users#all_supervisors"
    resources :reports, only: :index
    resources :user_courses, only: %i(create update destroy)
    resources :reports, only: :index
  end
end
