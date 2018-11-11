Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints subdomain: 'admin' do
    require 'sidekiq/web'
    require 'sidekiq/cron/web'
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      AdminAuth.call(username, password)
    end
    mount Sidekiq::Web => '/sidekiq'

    mount RailsAdmin::Engine => '/', as: 'rails_admin'
  end

  namespace :v1, defaults: { format: :json } do
    match '*any' => 'application#options', :via => [:options]
    post 'refresh', controller: :refresh, action: :create
    post 'signin', controller: :signin, action: :create
    post 'signup', controller: :signup, action: :create
    delete 'signin', controller: :signin, action: :destroy
    get 'profile', controller: :profile, action: :show

    resources :watchlists do
      member do
        post :activate
        post :deactivate
      end
    end
  end
end
