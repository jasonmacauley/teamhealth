Rails.application.routes.draw do
  get 'role/index'
  get 'role/show'
  get 'role/edit'
  get 'role/update'
  get 'role/delete'
  get 'role/create'
  get 'role/new'
  get 'team/index'
  get 'team/show'
  get 'team/edit'
  get 'team/update'
  get 'team/delete'
  get 'team/create'
  get 'team/new'
  get 'team_member/index'
  get 'team_member/show'
  get 'team_member/edit'
  get 'team_member/update'
  get 'team_member/delete'
  get 'team_member/create'
  get 'team_member/new'
  devise_for :users
  devise_for :models
  root "home#index"
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
