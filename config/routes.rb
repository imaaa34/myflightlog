Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
    omniauth_callbacks: 'public/omniauth_callbacks',
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'users/mypage' => 'users#show', as: 'user'
    get 'users/detail/edit' => 'users#edit', as: 'edit_user'
    patch 'users/mypage' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    get 'contacts/complete' => 'contacts#complete', as: 'complete_contact'
    resources :logs do
      collection do
        get 'search'
        get 'sort'
        get 'stats'
        get 'graph'
        get 'map'
      end
      resource :favorites, only: [:create, :destroy]
    end
    resources :contacts, only: [:new, :create]
    devise_scope :user do
      post 'users/guest_sign_in' => 'sessions#guest_sign_in'
    end
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    get 'users/search' => 'users#search', as: 'search_user'
    resources :users, only: [:index, :edit, :update]
  end
end
