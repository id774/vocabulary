RailsApp::Application.routes.draw do
  root :to => 'records#new'
  resources :records,
    :only => [:new, :create]
  resources :results,
    :only => [:index]
end
