Rails.application.routes.draw do

  get 'question_vote/up/:question_id', to: 'question_vote#up', as: :question_up
  get 'question_vote/down/:question_id', to: 'question_vote#down', as: :question_down
  
  get 'tags/search/:tag', to: 'tags#search', as: :tags
  get 'comments/new'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'home/index'


  concern :votable do

      get 'vote_up', to: "votes#vote_up"
      get 'vote_down', to: "votes#vote_down"

  end

  resources :questions, shallow: true, concerns: :votable do
    resources :comments
    resources :answers, except: [:new] do
      patch 'select', on: :member
      resources :comments
    end
  end
  

  root 'home#index'

end
