class Organization < ApplicationRecord
  belongs_to :organization_type
  belongs_to :organization
  has_many :organizations
  has_and_belongs_to_many :team_members
  has_many :organization_roles
  has_many :metrics
end
