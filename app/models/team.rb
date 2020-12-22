class Team < ApplicationRecord
  belongs_to :slice
  has_many :team_members, through: :team_memberships
end
