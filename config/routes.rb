Rails.application.routes.draw do
 resources :employees, :employments
  # get 'site/index'
  get 'site/increment', as: :increment
  root "employees#index"
end
