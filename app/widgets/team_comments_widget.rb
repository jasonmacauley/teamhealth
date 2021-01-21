class TeamCommentsWidget < BaseWidget
  NAME = 'Team Comments'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def widget_type
    @widget_type
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    members = org.all_org_members
    responses = {}
    options['questionnaire_id'].each do |id|
      questionnaire = Questionnaire.find(id)
      questionnaire.questions.select { |q| q.text =~ /comments/i }.each do |question|
        responses[questionnaire.name] = question.responses.reject { |r| r.value.nil? }
        responses[questionnaire.name].select! { |r| ! members.select { |m| m.id == r.team_member_id }.empty? }
      end
    end
    responses
  end
end
