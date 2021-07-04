Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#show', as: 'user'
    get 'users/detail/edit' => 'users#edit', as: 'edit_user'
    patch 'users/detail' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    get 'logs' => 'logs#searh'
    get 'logs/stats' => 'logs#stats', as: 'stats_log'
    get 'logs/graph' => 'logs#graph', as: 'graph_log'
    get 'logs/map' => 'logs#map', as: 'map_log'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'
    resources :logs do
      resource :favorites, only: [:create, :destroy]
    end
    resources :contacts, only: [:new, :create]
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update]
  end
end
