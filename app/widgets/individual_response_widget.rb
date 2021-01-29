class IndividualResponseWidget < BaseWidget
  NAME = 'Individual Response Widget'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    member = TeamMember.find(options['team_member_id'])[0]
    questionnaire = Questionnaire.find(options['questionnaire_id'][0])
    response_data = collect_questionnaire_data([member], questionnaire)
    build_chart(member, questionnaire, response_data)
  end

  private

  def build_chart(member, questionnaire, response_data)
    data_table = questionnaire_data_table(questionnaire, response_data)
    option = { width: 1200,
               height: 600,
               title: 'Qualitative Metrics for ' + member.name,
               legend: 'top' }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end
end
