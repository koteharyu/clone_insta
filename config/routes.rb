Rails.application.routes.draw do
  root 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
end
