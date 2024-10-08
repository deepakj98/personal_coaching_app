Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "students#index"
  resources :students, only: [:index, :new, :create, :show]
  post 'students/:id/pay_installment', to: 'installments#pay', as: 'pay_installment'

end
