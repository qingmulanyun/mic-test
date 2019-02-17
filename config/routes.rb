Rails.application.routes.draw do
  resources :addresses, only: [:index]
  post 'addresses/select', to: 'addresses#select'

  root 'addresses#home'

end

