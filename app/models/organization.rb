class Organization < ApplicationRecord
  belongs_to :organization_type
  belongs_to :organization
  has_many :organizations
  has_many :organization_roles
  has_many :team_members, through: :organization_roles
  has_many :metrics

  def all_org_members
    members = []
    team_members.each do |member|
      members.push(member)
    end
    organizations.each do |org|
      puts org.name
      org.all_org_members.each do |member|
        next unless members.select { |m| m.id == member.id }.empty?

        members.push(member)
      end
    end
    members
  end

  private

end
