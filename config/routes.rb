Rails.application.routes.draw do

  devise_for :users
  root 'admin/home#index'

   constraints(AdminDomainConstraint.new) do
       namespace :admin do
         resources :users
       end
   end
end

