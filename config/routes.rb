Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :login, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :refresh, only: :create
      resources :signup, only: :create
      resources :notifications, only: :index

      resources :avatar do
        get 'presigned_url', on: :collection
      end

      resources :users do
        get 'me', on: :collection

        member do
          get :following, :followers, :online, :subscriptions, :new_comments
        end
      end

      resources :tags, only: [:index, :show], param: :name do
        member do
          get :spaces
        end
      end

      resources :spaces do
        member do
          get :comments, to: "spaces#comments"
        end

        collection do
          get :unsubscribed
          get :subscribed
          get :trend
        end
      end

      resources :account_activations do
        post ':token', action: :create, on: :collection
      end

      resources :password_resets do
        collection do
          get ':token', action: :edit
          patch ':token', action: :update
        end
      end

      resources :subscriptions do
        collection do
          post :create
          delete ':space_id/:user_id', action: :destroy
        end
      end
    end
  end

  root to: 'home#index'
  get '*path', to: 'home#index'
  mount ActionCable.server => "/cable"

  resources :auth do
    post ':provider', action: :create, on: :collection
  end
end
