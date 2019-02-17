Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "static_pages#welcome"
  get "/home", to: "home_pages#index"

  devise_for :users, controllers: {sessions: "users/sessions",
    registrations: "registrations"}
  resources :reset_password, only: %i(edit update)
  resources :users, only: %i(edit show)
  resources :user_courses, only: %i(new create show destroy), controller: "courses", as: "courses"

  resources :learns, only: :show
  resources :tasks, only: %i(show update)
  resources :comments do
    member do
      get :new_reply
    end
  end

  namespace :trainee do
    get "/members", to: "users#all_users"
    get "/courses/:id/members", to: "courses#show_member"
    resources :reports, only: %i(index new create)
    resources :courses, only: %i(index show)
  end

  namespace :supervisor do
    resources :users, except: :show
    get "/all_supervisors", to: "users#all_supervisors"
    resources :reports, only: :index
    resources :user_courses, only: %i(create update destroy)
    resources :courses do
      resources :subjects do
        patch "/finish", to: "subjects#finish"
      end
      patch "/finish", to: "courses#finish"
    end
  end
end
