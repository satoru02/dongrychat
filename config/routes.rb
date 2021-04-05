# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                  root GET    /                                                                                        home#index
#                                       POST   /auth/:provider(.:format)                                                                auth#create
#                            auth_index POST   /auth(.:format)                                                                          auth#create
#                   api_v1_signup_index POST   /api/v1/signup(.:format)                                                                 api/v1/signup#create
#                    api_v1_login_index POST   /api/v1/login(.:format)                                                                  api/v1/login#create
#                          api_v1_login DELETE /api/v1/login/:id(.:format)                                                              api/v1/login#destroy
#                  api_v1_refresh_index POST   /api/v1/refresh(.:format)                                                                api/v1/refresh#create
#                                       POST   /api/v1/signup(.:format)                                                                 api/v1/signup#create
#                                       POST   /api/v1/account_activations/:token(.:format)                                             api/v1/account_activations#create
#            api_v1_account_activations POST   /api/v1/account_activations(.:format)                                                    api/v1/account_activations#create
#           edit_api_v1_password_resets GET    /api/v1/password_resets/:token(.:format)                                                 api/v1/password_resets#edit
#                                       PATCH  /api/v1/password_resets/:token(.:format)                                                 api/v1/password_resets#update
#                api_v1_password_resets POST   /api/v1/password_resets(.:format)                                                        api/v1/password_resets#create
#                       me_api_v1_users GET    /api/v1/users/me(.:format)                                                               api/v1/users#me
#                          api_v1_users GET    /api/v1/users(.:format)                                                                  api/v1/users#index
#                                       POST   /api/v1/users(.:format)                                                                  api/v1/users#create
#                       new_api_v1_user GET    /api/v1/users/new(.:format)                                                              api/v1/users#new
#                      edit_api_v1_user GET    /api/v1/users/:id/edit(.:format)                                                         api/v1/users#edit
#                           api_v1_user GET    /api/v1/users/:id(.:format)                                                              api/v1/users#show
#                                       PATCH  /api/v1/users/:id(.:format)                                                              api/v1/users#update
#                                       PUT    /api/v1/users/:id(.:format)                                                              api/v1/users#update
#                                       DELETE /api/v1/users/:id(.:format)                                                              api/v1/users#destroy
#                  api_v1_subscriptions GET    /api/v1/subscriptions(.:format)                                                          api/v1/subscriptions#index
#                                       POST   /api/v1/subscriptions(.:format)                                                          api/v1/subscriptions#create
#               new_api_v1_subscription GET    /api/v1/subscriptions/new(.:format)                                                      api/v1/subscriptions#new
#              edit_api_v1_subscription GET    /api/v1/subscriptions/:id/edit(.:format)                                                 api/v1/subscriptions#edit
#                   api_v1_subscription GET    /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#show
#                                       PATCH  /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#update
#                                       PUT    /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#update
#                                       DELETE /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#destroy
#                   enter_api_v1_spaces GET    /api/v1/spaces/enter(.:format)                                                           api/v1/spaces#enter
# enter_from_subscription_api_v1_spaces GET    /api/v1/spaces/enter_from_subscription(.:format)                                         api/v1/spaces#enter_from_subscription
#                         api_v1_spaces GET    /api/v1/spaces(.:format)                                                                 api/v1/spaces#index
#                                       POST   /api/v1/spaces(.:format)                                                                 api/v1/spaces#create
#                      new_api_v1_space GET    /api/v1/spaces/new(.:format)                                                             api/v1/spaces#new
#                     edit_api_v1_space GET    /api/v1/spaces/:id/edit(.:format)                                                        api/v1/spaces#edit
#                          api_v1_space GET    /api/v1/spaces/:id(.:format)                                                             api/v1/spaces#show
#                                       PATCH  /api/v1/spaces/:id(.:format)                                                             api/v1/spaces#update
#                                       PUT    /api/v1/spaces/:id(.:format)                                                             api/v1/spaces#update
#                                       DELETE /api/v1/spaces/:id(.:format)                                                             api/v1/spaces#destroy
#                                       GET    /*path(.:format)                                                                         home#index
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do

  root to: 'home#index'
  mount ActionCable.server => "/cable"

  resources :auth, only: [:create] do
    collection do
      post ':provider', action: :create
    end
  end

  namespace 'api' do
    namespace 'v1' do
      get '/avatar/presigned_url', to: 'avatar#presigned_url'
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
        member do
          get :following, :followers
        end
      end

      resources :relationships, only: [:create, :destroy]
      resources :subscriptions
      resources :spaces do
        collection do
          get :enter
          get :enter_from_subscription
          get :trend
        end
      end
    end
  end

  get '*path', to: 'home#index'
end
