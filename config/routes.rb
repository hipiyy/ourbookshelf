Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tweets
  root 'tweets#index'
  resources :users, only: [:show] 
  get 'rooms/:id/create' => 'rooms#create'
  get 'rooms/:id' => 'rooms#show' 
  get 'rooms/:id/destroy' => 'rooms#destroy'
  post 'messages/:id/:tweet_id/create' => 'messages#create' 
  get 'messages/:id/destroy' => 'messages#destroy'
  get "/file/:name" => "tweets#downloadpdf"

end
