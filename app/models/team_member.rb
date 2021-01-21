class TeamMember < ApplicationRecord
  belongs_to :user
  belongs_to :title
  belongs_to :location
  has_many :organization_roles
  has_many :organizations, through: :organization_roles
end
