Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  resources :users, only: :show do
    resources :videos, to: "users/videos#index", only: :index
  end

  get "/videos", to: "users/videos#index"
  resources :registrations
  post "/registrations/:id" => "registrations#show"
  post "/hook" => "registrations#hook"
end
