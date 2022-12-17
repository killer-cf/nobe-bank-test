Rails.application.routes.draw do
  delete '/clients', to: ->(env) { [404, {}, ['']] }
  devise_for :clients, controllers: { registrations: 'clients/registrations', sessions: 'clients/sessions' }
  devise_scope :client do
    post 'close_account', to: 'clients/registrations#close_account'
  end
  root to: 'home#index'
end
