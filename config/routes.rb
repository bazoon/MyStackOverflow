Rails.application.routes.draw do
  use_doorkeeper

  default_url_options :host => "example.com" #TODO: why is that ?

  get 'question_vote/up/:question_id', to: 'question_vote#up', as: :question_up
  get 'question_vote/down/:question_id', to: 'question_vote#down', as: :question_down
  
  get 'tags/search/:tag', to: 'tags#search', as: :tag_search
  get 'tags', to: 'tags#tags', as: :tags


  get 'comments/new'

  # devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                   confirmations: 'confirmations',
                                    registrations: 'registrations' }

  devise_scope :user do
    post 'save_email', to: 'omniauth_callbacks#save_email'
  end


  get 'home/index'

  concern :votable do
    patch 'vote_up', to: 'votes#vote_up'
    patch 'vote_down', to: 'votes#vote_down'
  end

  concern :commentable do
    resources :comments
  end

  resources :questions, shallow: true, concerns: [:votable, :commentable] do
    resources :answers, except: [:new], concerns: [:votable, :commentable] do
      patch 'select', on: :member
    end
  end
  

  namespace :api do
    namespace :v1 do
      
      resources :profiles do
        get :me, on: :collection
      end
      
      resources :answers, only: [:show]

      resources :questions, only: [:index, :show, :create] do
        resources :answers, only: [:index, :create]
      end

    end
  end


  root 'home#index'

end
