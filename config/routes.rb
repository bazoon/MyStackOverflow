Rails.application.routes.draw do
  get 'tags/search/:tag', to: 'tags#search', as: :tags
  get 'comments/new'

  devise_for :users, controllers: { registrations: 'registrations' }

  get 'home/index'

  concern :votable do
    get 'vote_up', to: 'votes#vote_up'
    get 'vote_down', to: 'votes#vote_down'
  end

  resources :questions, shallow: true, concerns: :votable do
    resources :comments
    resources :answers, except: [:new], concerns: :votable do
      patch 'select', on: :member
      resources :comments
    end
  end
  

  root 'home#index'

end
