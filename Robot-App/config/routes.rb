Rails.application.routes.draw do
	namespace :api do
		resources :robots do
			member do
				post "/orders" => "robots#do_orders"
			end
		end
	end
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
