class TeamMemberWidget < BaseWidget
  NAME = 'Team Members'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def widget_type
    @widget_type
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    members = org.all_org_members
    data = {}
    members.each do |member|
      member.organizations.each do |org|
        data[org] = [] if data[org].nil?
        data[org].push(member)
      end
    end
    data
  end
end
