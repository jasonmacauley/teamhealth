class QualitativeTableWidget < BaseWidget
  NAME = 'Qualitative Table'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def widget_type
    @widget_type
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    members = org.all_org_members
    data = []
    options['questionnaire_id'].each do |id|
      questionnaire = Questionnaire.find(id)
      responses = collect_questionnaire_data(members, questionnaire)
      response_stats = ResponseStatCalculator.new.response_data_by_month(org, questionnaire)
      response_stats.each do |key, values|
        responses['response_count'] = {} if responses['response_count'].nil?
        responses['response_rate'] = {} if responses['response_rate'].nil?
        responses['response_count'][key] = values['count']
        responses['response_rate'][key] = values['rate']
      end
      responses['questionnaire'] = questionnaire
      data.push(responses)
    end
    data
  end
end
