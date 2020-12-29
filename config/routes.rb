Rails.application.routes.draw do

  root :to => 'messages#index'

  resources :messages

  post '/reissue_lost_script', to: 'payments#reissue_lost_script', as: 'reissue_lost_script'
end
