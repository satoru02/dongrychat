Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :login, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :refresh, only: :create
      resources :signup, only: :create
      resources :notifications, only: :index
      resources :reviews, only: [:index, :show, :create, :update]

      resources :avatar do
        get 'presigned_url', on: :collection
      end

      resources :users do
        get 'me', on: :collection
        member do
          get :following, :followers, :online, :subscriptions, :new_comments, :reviews
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
          get :reviews, to: "spaces#reviews"
        end

        collection do
          get :unsubscribed
          get :subscribed
          get :trend
          get :popular
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

      resources :watchlists do
        collection do
          post :create
          patch ':space_id/:user_id', action: :update
          delete ':space_id/:user_id', action: :destroy
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
