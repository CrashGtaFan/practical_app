PracticalApp::Application.routes.draw do
  resources :items do
    collection { post :sort }
  end
  root to: 'items#index'
end
