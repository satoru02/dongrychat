Rails.application.routes.draw do
  root to: 'home#index'

  namespace 'api' do
    namespace 'v1' do
      resources :signup, only: [:create]
      resources :login, only: [:create, :destroy]
      resources :refresh, only: [:create]
      resources :signup, only: [:create]
      resources :account_activations, only: [:create] do
        collection do
          post ':token', action: :create
        end
      end

      resources :password_resets, only: [:create] do
        collection do
          get ':token', action: :edit, as: :edit
          patch ':token', action: :update
        end
      end

      resources :users do
        collection do
          get :me
        end
      end
    end
  end

  get '*path', to: 'home#index'
end
