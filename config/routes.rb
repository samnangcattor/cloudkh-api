Rails.application.routes.draw do
  resources :users, only: [:index, :show]

  get "/videos", to: "users/videos#index"
end
