MyrlundNo::Application.routes.draw do
  
  scope "(:locale)" do
  
    devise_for :users
    
    resources :posts do
      get :drafts, on: :collection
    end
    resources :categories
    resources :users
  
    root to: 'posts#index'
    
  end
  match '/:locale' => 'posts#index'
  
end
