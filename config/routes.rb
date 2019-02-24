Rails.application.routes.draw do
  root "static_pages#welcome"
  get "/home", to: "home_pages#index"

  devise_for :users, controllers: {sessions: "users/sessions", registrations: "registrations"}
  resources :reset_password, only: %i(edit update)
  resources :users, only: %i(edit show) do
    resources :tests, only: %i(index show create update)
  end

  resources :courses
  resources :user_courses, only: %i(new create show destroy)
  resources :learns, only: :show
  scope :learn do
    resources :tasks, only: %i(show update)
  end
  resources :comments do
    member do
      get :new_reply
    end
  end

  namespace :supervisor do
    resources :tests
    resources :exams do
      resources :questions do
        resources :answers
      end
    end
    resources :users, except: :show
    resources :reports, only: :index
    resources :user_courses, only: %i(create update destroy)
    resources :courses do
      resources :subjects do
        patch "/finish", to: "subjects#finish"
      end
      patch "/finish", to: "courses#finish"
    end
  end

  namespace :trainee do
    get "/courses/:id/members", to: "courses#show_member"
    resources :reports, only: %i(index new create)
    resources :courses, only: %i(index show)
  end
end
