Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    root 'static_page#home'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/logged_in', to: 'sessions#method_logged_in?'
    resources :users,  only: %i[create show index] do
      resources :schedules do
        resources :tasks
      end
    end
  end
end
