class OrganizationMember < ApplicationRecord
  belongs_to :organization
  belongs_to :team_member
end
