Todo::Application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    resources :task_lists, only: [:index] do
      resources :tasks, only: [:index, :create, :update, :destroy]
    end
  end

  root :to => "home#index"
end
