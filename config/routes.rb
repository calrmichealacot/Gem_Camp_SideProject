Rails.application.routes.draw do

  constraints(AdminDomainConstraint.new) do
    devise_for :users, as: 'admin', controllers: { sessions: 'admin/sessions'}
    namespace :admin do
      resources :users
    end
  end

  constraints(ClientDomainConstraint.new) do
    devise_for :users, as: 'client', controllers: { sessions: 'client/sessions', registrations: 'client/registrations' }
    resources :posts do
    end
  end

  root 'admin/home#index'
end

