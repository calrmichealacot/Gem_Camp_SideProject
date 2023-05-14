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
      resources :profiles, only:[:show, :edit, :update]
    end
  end
end

namespace :api do
  namespace :v1 do
    resources :regions, only: %i[index show], defaults: { format: :json } do
      resources :provinces, only: :index, defaults: { format: :json }
    end

    resources :provinces, only: %i[index show], defaults: { format: :json } do
      resources :cities, only: :index, defaults: { format: :json }
    end

    resources :cities, only: %i[index show], defaults: { format: :json } do
      resources :barangays, only: :index, defaults: { format: :json }
    end

    resources :barangays, only: %i[index show], defaults: { format: :json }
  end
end


