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
    responses = {}
    options['questionnaire_id'].each do |id|
      questionnaire = Questionnaire.find(id)
      questionnaire.questions.select { |q| q.text =~ /comments/i }.each do |question|
        responses[questionnaire.name] = question.responses.select { |r| ! r.value.nil? }
      end
    end
    responses
  end
end
