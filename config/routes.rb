Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    match '*any' => 'application#options', :via => [:options]
    post 'refresh', controller: :refresh, action: :create
    post 'signin', controller: :signin, action: :create
    post 'signup', controller: :signup, action: :create
    delete 'signin', controller: :signin, action: :destroy
    get 'profile', controller: :profile, action: :show

    resources :watchlists
  end
end
