class TeamQualitativeChartWidget < BaseWidget
  NAME = 'Team Qualitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    members = org.all_org_members
    questionnaire = Questionnaire.find(options['questionnaire_id'][0])
    response_data = collect_questionnaire_data(members, questionnaire)
    build_chart(org, questionnaire, response_data)
  end

  private

  def build_chart(org, questionnaire, response_data)
    data_table = questionnaire_data_table(questionnaire, response_data)
    option = { width: 1200,
               height: 600,
               title: 'Qualitative Metrics for ' + org.name,
               legend: 'top' }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end
end
