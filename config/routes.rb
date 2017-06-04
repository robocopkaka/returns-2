Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'payments/return' => 'payments#remita_return'
  post 'payments/poster' => 'payments#temp_poster'
  resources :payments, only: [:new]
  #mount HyperMesh::Engine => '/rr'
  get 'platform/index'

  get 'platform/error'
  post 'platform/country_states'

  resources :companies, only: [:show, :update] do
    collection do
      get 'retrieve'
    end
  end

  get 'filing/:id/annual' => 'filing#annual', as: :filing_annual

  get 'filing/home'

  get 'filing/show'

  get 'filing/new'

  post 'filing/sampler'
  get 'filing/incoming'


  # mount ReactiveRecord::Engine => '/rr'
  root 'platform#index'
end
