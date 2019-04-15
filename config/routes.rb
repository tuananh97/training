Rails.application.routes.draw do
    mount Ckeditor::Engine => '/ckeditor'
    mount ActionCable.server => '/cable'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#welcome"
    get "/home", to: "home_pages#index"

    resources :notifications
    devise_for :users, controllers: {sessions: "users/sessions",
      registrations: "registrations"}
    resources :reset_password, only: %i(edit update)

    resources :users, only: %i(edit show) do
      resources :tests, only: %i(index show create update)
    end
    resources :courses
    resources :user_courses, only: %i(new create show destroy)
    resources :learns, only: :show

    scope :learn do
      get "/exam_details/:id", to: "learns#exam_details", as: "exam_details"
      resources :tasks, only: %i(show update)
    end

    resources :comments do
      member do
        get :new_reply
      end
    end

    namespace :admin do
      resources :users, except: :show
      resources :courses, only: %i(index show)
    end

    namespace :supervisor do
      resources :courses do
        resources :subjects do
          resources :tasks
          patch "/finish", to: "subjects#finish"
        end
        patch "/finish", to: "courses#finish"
      end
      resources :exams do
        get "/results", to: "exams#results", as: "results"
        resources :tests, only: :show
        resources :questions do
          resources :answers
        end
      end
      resources :user_courses, only: %i(create update destroy)
      resources :reports, only: :index
    end

    namespace :trainee do
      get "/courses/:id/members", to: "courses#show_member"
      resources :reports, only: %i(index new create)
      resources :courses, only: %i(index show)
    end
  end
end
