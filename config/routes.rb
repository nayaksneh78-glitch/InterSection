Rails.application.routes.draw do
  root "properties#index"
  resources :properties, only: %i[index show] do
    resources :city_gems, only: :show
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
