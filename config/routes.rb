# frozen_string_literal: true

Rails.application.routes.draw do
  root('home#index')

  namespace(:league) do
    resources(:games, only: %i[show index])
    resources(:standings, only: %i[show index])
  end

  resources(:votes, only: %i[create index])

  resources(:active_sessions, only: [:destroy])

  put('account', to: 'friends#update')
  get('account', to: 'friends#edit')
  delete('account', to: 'friends#destroy')

  post('sign_up', to: 'friends#create')
  get('sign_up', to: 'friends#new')

  post('sign_in', to: 'sessions#create')
  get('sign_in', to: 'sessions#new')

  get('sign_out', to: 'sessions#destroy')
end
