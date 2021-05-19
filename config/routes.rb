# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                  root GET    /                                                                                        home#index
#                                              /cable                                                                                   #<ActionCable::Server::Base:0x00007ffadf714580 @config=#<ActionCable::Server::Configuration:0x00007ffae80b6090 @log_tags=[], @connection_class=#<Proc:0x00007ffadf6ce238 /Users/sugiwaka/.rbenv/versions/2.7.2/lib/ruby/gems/2.7.0/gems/actioncable-6.0.3.5/lib/action_cable/engine.rb:37 (lambda)>, @worker_pool_size=4, @disable_request_forgery_protection=false, @allow_same_origin_as_host=true, @logger=#<Logger:0x00007ffae82f7548 @level=0, @progname=nil, @default_formatter=#<Logger::Formatter:0x00007ffae82f7520 @datetime_format=nil>, @formatter=#<Proc:0x00007ffae82f7200 /Users/sugiwaka/living-room/config/environments/development.rb:4>, @logdev=#<Logger::LogDevice:0x00007ffae82f74d0 @shift_period_suffix="%Y%m%d", @shift_size=1048576, @shift_age="daily", @filename="log/development.log", @dev=#<File:log/development.log>, @binmode=false, @mon_data=#<Monitor:0x00007ffae82f7480>, @mon_data_owner_object_id=12000, @next_rotate_time=2021-04-13 00:00:00 +0900>>, @cable={"adapter"=>"async"}, @mount_path="/cable", @allowed_request_origins=/https?:\/\/localhost:\d+/>, @mutex=#<Monitor:0x00007ffadf714530>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
#                                       POST   /auth/:provider(.:format)                                                                auth#create
#                            auth_index POST   /auth(.:format)                                                                          auth#create
#           api_v1_avatar_presigned_url GET    /api/v1/avatar/presigned_url(.:format)                                                   api/v1/avatar#presigned_url
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
#                 following_api_v1_user GET    /api/v1/users/:id/following(.:format)                                                    api/v1/users#following
#                 followers_api_v1_user GET    /api/v1/users/:id/followers(.:format)                                                    api/v1/users#followers
#                          api_v1_users GET    /api/v1/users(.:format)                                                                  api/v1/users#index
#                                       POST   /api/v1/users(.:format)                                                                  api/v1/users#create
#                       new_api_v1_user GET    /api/v1/users/new(.:format)                                                              api/v1/users#new
#                      edit_api_v1_user GET    /api/v1/users/:id/edit(.:format)                                                         api/v1/users#edit
#                           api_v1_user GET    /api/v1/users/:id(.:format)                                                              api/v1/users#show
#                                       PATCH  /api/v1/users/:id(.:format)                                                              api/v1/users#update
#                                       PUT    /api/v1/users/:id(.:format)                                                              api/v1/users#update
#                                       DELETE /api/v1/users/:id(.:format)                                                              api/v1/users#destroy
#                  api_v1_relationships POST   /api/v1/relationships(.:format)                                                          api/v1/relationships#create
#                   api_v1_relationship DELETE /api/v1/relationships/:id(.:format)                                                      api/v1/relationships#destroy
#                  api_v1_subscriptions POST   /api/v1/subscriptions(.:format)                                                          api/v1/subscriptions#create
#           delete_api_v1_subscriptions DELETE /api/v1/subscriptions/:space_id/:user_id(.:format)                                       api/v1/subscriptions#delete
#                                       GET    /api/v1/subscriptions(.:format)                                                          api/v1/subscriptions#index
#                                       POST   /api/v1/subscriptions(.:format)                                                          api/v1/subscriptions#create
#               new_api_v1_subscription GET    /api/v1/subscriptions/new(.:format)                                                      api/v1/subscriptions#new
#              edit_api_v1_subscription GET    /api/v1/subscriptions/:id/edit(.:format)                                                 api/v1/subscriptions#edit
#                   api_v1_subscription GET    /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#show
#                                       PATCH  /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#update
#                                       PUT    /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#update
#                                       DELETE /api/v1/subscriptions/:id(.:format)                                                      api/v1/subscriptions#destroy
#                   enter_api_v1_spaces GET    /api/v1/spaces/enter(.:format)                                                           api/v1/spaces#enter
# enter_from_subscription_api_v1_spaces GET    /api/v1/spaces/enter_from_subscription(.:format)                                         api/v1/spaces#enter_from_subscription
#                   trend_api_v1_spaces GET    /api/v1/spaces/trend(.:format)                                                           api/v1/spaces#trend
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
  namespace 'api' do
    namespace 'v1' do
      resources :login, only: [:create, :destroy]
      resources :relationships, only: [:create, :destroy]
      resources :refresh, only: :create
      resources :signup, only: :create
      resources :notifications, only: :index
      resources :comments, only: :index
      resources :avatar do
        get 'presigned_url', on: :collection
      end

      resources :users do
        get 'me', on: :collection
        member do
          get :following, :followers, :online
        end
      end

      resources :tags do
        get 'members', on: :collection
      end

      resources :spaces do
        collection do
          get :enter
          get :enter_from_subscription
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
