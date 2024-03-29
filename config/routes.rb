Rails.application.routes.draw do
  get 'widget/index'
  get 'widget/show/:id' => 'widget#show', as: :show_widget
  get 'widget/new/:id' => 'widget#new', as: :new_widget
  get 'widget/edit/:id' => 'widget#edit', as: :edit_widget
  post 'widgets' => 'widget#update'
  patch 'widgets' => 'widget#update'
  post 'widget/combo_chart_config' => 'widget#combo_chart_config', as: :config_combo_chart
  get 'widget/delete/:id' => 'widget#delete', as: :delete_widget
  get 'widget/preview/:id' => 'widget#preview', as: :preview_widget
  get 'widget_config_type/index'
  get 'widget_config_type/show/:id' => 'widget_config_type#show', as: :show_widget_config_type
  get 'widget_config_type/edit/:id' => 'widget_config_type#edit', as: :edit_widget_config_type
  get 'widget_config_type/new'
  post 'widget_config_types' => 'widget_config_type#update'
  patch 'widget_config_types' => 'widget_config_type#update'
  get 'widget_config_type/delete/:id' => 'widget_config_type#delete', as: :delete_widget_config_type
  get 'widget_type/index'
  get 'widget_type/add' => 'widget_type#add_widget_types', as: :add_widget_types
  get 'widget_type/show/:id' => 'widget_type#show', as: :show_widget_type
  get 'widget_type/edit/:id' => 'widget_type#edit', as: :edit_widget_type
  get 'widget_type/new'
  post 'widget_types' => 'widget_type#update'
  patch 'widget_types' => 'widget_type#update'
  get 'widget_type/delete/:id' => 'widget_type#delete', as: :delete_widget_type
  get 'dashboard/index'
  get 'dashboard/show/:id' => 'dashboard#show', as: :show_dashboard
  get 'dashboard/new'
  get 'dashboard/edit/:id' => 'dashboard#edit', as: :edit_dashboard
  post 'dashboards' => 'dashboard#update'
  patch 'dashboards' => 'dashboard#update'
  patch 'dashboard/add_widget' => 'dashboard#add_widget', as: :add_widget
  get 'dashboard/delete/:id' => 'dashboard#delete', as: :delete_dashboard
  post 'dashboard/generate_org_dashboards' => 'dashboard#generate_organization_dashboards', as: :generate_dashboards
  patch 'import_qualitative/import'
  get 'import_qualitative/index/:id' => 'import_qualitative#index', as: :import_quailitative
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
  get 'questionnaire/clone_questionnaire/:id' => 'questionnaire#clone_questionnaire', as: :clone_questionnaire
  get 'questionnaire/clone_question/:id' => 'questionnaire#clone_question', as: :clone_question
  get 'questionnaire/new'
  get 'questionnaire/edit/:id' => 'questionnaire#edit', as: :edit_questionnaire
  get 'questionnaire/delete/:id' => 'questionnaire#delete', as: :delete_questionnaire
  get 'questionnaire/display/:id' => 'questionnaire#display', as: :display_questionnaire
  patch 'questionnaire/collect/:id' => 'questionnaire#collect', as: :collect_response
  get 'questionnaire/thanks/:id' => 'questionnaire#thanks', as: :response_thanks
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
  patch 'organization/update_metric_types' => 'organization#update_metric_types', as: :update_organization_metric_types
  patch 'organization/set_organization_metric_defaults' => 'organization#set_organization_metric_defaults', as: :set_organization_metric_defaults
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
