class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :title
  has_many :organization_roles
  has_and_belongs_to_many :organizations
end
