Rails.application.routes.draw do
  get 'title/index'
  get 'title/show/:id' => 'title#show', as: :title
  get 'title/edit/:id' => 'title#edit', as: :edit_title
  get 'title/new'
  post 'titles' => 'title#update'
  patch 'titles' => 'title#update'
  get 'title/delete/:id' => 'title#delete', as: :delete_title
  get 'organization/index'
  get 'organization/show/:id' => 'organization#show', as: :organization
  get 'organization/edit/:id' => 'organization#edit', as: :edit_organization
  get 'organization/add/:id' => 'organization#new', as: :add_organization
  post 'organizations' => 'organization#update'
  patch 'organizations' => 'organization#update'
  get 'organization/new'
  get 'organization/delete'
  get 'organization_type/index'
  get 'organization_type/show/:id' => 'organization_type#show', as: :organization_type
  get 'organization_type/edit/:id' => 'organization_type#edit', as: :edit_organnization_type
  post 'organization_types' => 'organization_type#update'
  patch 'organization_types' => 'organization_type#update'
  get 'organization_type/new'
  get 'organization_type/delete/:id' => 'organization_type#delete', as: :delete_organization_type
  get 'role/index'
  get 'role/show/:id' => 'role#show', as: :role
  get 'role/edit/:id' => 'role#edit', as: :edit_role
  get 'role/delete/:id' => 'role#delete', as: :delete_role
  post 'roles' => 'role#update'
  patch 'roles' => 'role#update'
  get 'role/new'
  get 'team_member/index'
  get 'team_member/show/:id' => 'team_member#show', as: :show_team_member
  get 'team_member/edit/:id' => 'team_member#edit', as: :edit_team_member
  post 'team_members' => 'team_member#update'
  patch 'team_members' => 'team_member#update'
  get 'team_member/delete/:id' => 'team_member#delete', as: :delete_team_member
  get 'team_member/new'
  post 'team_member/import' => 'team_member#import', as: :import_team_members
  devise_for :users
  root "home#index"
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
