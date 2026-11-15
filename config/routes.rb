Rails.application.routes.draw do
 get '/health/live',to:'health#live'
 get '/ready',to:'health#ready'
resources :ingredients,only:[:create]
resources :recipes,only:[:create,:show,:index]
end
