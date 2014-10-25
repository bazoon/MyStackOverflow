Rails.application.routes.draw do

  get 'question_vote/up/:question_id', to: 'question_vote#up', as: :question_up
  get 'question_vote/down/:question_id', to: 'question_vote#down', as: :question_down
  
  get 'tags/search/:tag', to: 'tags#search', as: :tag_search
  get 'tags', to: 'tags#tags', as: :tags


  get 'comments/new'

  # devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

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
  

  root 'home#index'

end
