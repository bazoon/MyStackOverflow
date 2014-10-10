Rails.application.routes.draw do

  get 'question_vote/up/:question_id', to: 'question_vote#up', as: :question_up
  get 'question_vote/down/:question_id', to: 'question_vote#down', as: :question_down
  
  get 'question_tags/search/:tag', to: 'question_tags#search', as: :question_tags
  get 'comments/new'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'home/index'

  resources :questions, shallow: true do
    resources :comments
    resources :answers, except: [:new] do
      patch 'select', on: :member
      resources :comments
    end
  end
  

  root 'home#index'


end
