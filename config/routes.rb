Rails.application.routes.draw do

	root to: 'gossips#index'
	get 'static_pages/team', to: 'static_pages#team', as: 'team'
	get 'static_pages/contact', to: 'static_pages#contact', as: 'contact'
	get 'static_pages/:first_name', to: 'static_pages#welcome', as: 'secret_page'

	resources :gossips do
		resources :comments
	end
	resources :users
	resources :cities, only: [:show]
	resources :sessions, only: [:new, :create, :destroy]
	resources :likes, only: [:create, :destroy]

end
