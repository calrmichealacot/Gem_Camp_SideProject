Rails.application.routes.draw do
  devise_for :users
  root 'admin/home#index'
end

