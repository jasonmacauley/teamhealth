class OrganizationRole < ApplicationRecord
  belongs_to :organization
  belongs_to :team_member
  belongs_to :role
end
