Rails.application.routes.draw do
  delete '/clients', to: ->(env) { [404, {}, ['']] }
  devise_for :clients, controllers: { registrations: 'clients/registrations', sessions: 'clients/sessions' }
  devise_scope :client do
    post 'close_account', to: 'clients/registrations#close_account'
  end
  root to: 'home#index'
  get 'deposit', to: 'transactions#deposit'
  patch 'send_deposit', to: 'transactions#send_deposit'
  get 'withdraw', to: 'transactions#withdraw'
  patch 'send_withdraw', to: 'transactions#send_withdraw'
  get 'transfer', to: 'transactions#transfer'
  patch 'send_transfer', to: 'transactions#send_transfer'

  resources :account_statements, only: :index do
    get 'filter', on: :collection
  end
end
