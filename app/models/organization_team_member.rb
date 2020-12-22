class OrganizationsTeamMember < ApplicationRecord
  has_one :team_member
  has_one :organization
end
