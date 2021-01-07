Rails.application.routes.draw do
  get 'question_option/new/:id' => 'question_option#new', as: :add_question_option
  get 'question_option/edit/:id' => 'question_option#edit', as: :edit_question_option
  post 'question_options' => 'question_option#update'
  patch 'question_options' => 'question_option#update'
  get 'question_option/delete/:id' => 'question_option#delete', as: :delete_question_option
  get 'question/new/:id' => 'question#new', as: :add_question
  get 'question/edit/:id' => 'question#edit', as: :edit_question
  get 'question/delete/:id' => 'question#delete', as: :delete_question
  post 'questions' => 'question#update'
  patch 'questions' => 'question#update'
  get 'question_type/index'
  get 'question_type/show/:id' => 'question_type#show', as: :show_question_type
  post 'question_types' => 'question_type#update'
  patch 'question_types' => 'question_type#update'
  get 'question_type/new'
  get 'question_type/edit/:id' => 'question_type#edit', as: :edit_question_type
  get 'question_type/delete/:id' => 'question_type#delete', as: :delete_question_type
  get 'questionnaire/index'
  get 'questionnaire/show/:id' => 'questionnaire#show', as: :show_questionnaire
  post 'questionnaires' => 'questionnaire#update'
  patch 'questionnaires' => 'questionnaire#update'
  get 'questionnaire/new'
  get 'questionnaire/edit/:id' => 'questionnaire#edit', as: :edit_questionnaire
  get 'questionnaire/delete/:id' => 'questionnaire#delete', as: :delete_questionnaire
  get 'metrics/add/:id' => 'metrics#add', as: :add_metrics
  post 'metrics/update'
  get 'metrics/delete'
  post 'metrics/import' => 'metrics#import', as: :import_metrics
  get 'metric_type/index'
  get 'metric_type/show/:id' => 'metric_type#show', as: :show_metric_type
  get 'metric_type/edit/:id' => 'metric_type#edit', as: :edit_metric_type
  get 'metric_type/new'
  post 'metric_types' => 'metric_type#update'
  patch 'metric_types' => 'metric_type#update'
  get 'metric_type/delete/:id' => 'metric_type#delete', as: :delete_metric_type
  get 'organization_roles/index'
  get 'organization_roles/update'
  get 'organization_roles/show'
  get 'organization_roles/delete'
  get 'organization_roles/new'
  get 'location/index'
  get 'location/edit/:id' => 'location#edit', as: :edit_location
  post 'locations' => 'location#update'
  patch 'locations' => 'location#update'
  get 'location/new'
  get 'location/delete/:id' => 'location#delete', as: :delete_location
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
  patch 'team_member/add_role/:id' => 'team_member#add_role', as: :add_team_member_role
  get 'team_member/remove_role/:id' => 'team_member#remove_role', as: :remove_team_member_role
  devise_for :users
  root "home#index"
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
