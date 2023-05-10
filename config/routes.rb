Rails.application.routes.draw do

  root 'home#index'
  constraints(AdminDomainConstraint.new) do
    devise_for :users, as: 'admin', controllers: { sessions: 'admin/sessions' }
    namespace :admin do
      resources :users
    end
  end

  constraints(ClientDomainConstraint.new) do
    devise_for :users, as: 'client', controllers: { sessions: 'client/sessions', registrations: 'client/registrations' }
    namespace :client do
    end
  end
end



