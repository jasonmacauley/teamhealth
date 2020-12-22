class TeamMembership < ApplicationRecord
  belongs_to :team_member
  belongs_to :team
  has_one :role
end
