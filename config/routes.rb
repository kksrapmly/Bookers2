Rails.application.routes.draw do


  get '/'  => 'root#top'
  get '/about' => 'root#about'
  root 'root#top'


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books
  resources :users, only:[:index, :show, :edit, :update]
end