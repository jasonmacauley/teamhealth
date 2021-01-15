class TeamQualitativeChartWidget < BaseWidget
  NAME = 'Team Qualitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    org = Organization.find(options['organization_id'])
    members = org.all_org_members
    questionnaire = Questionnaire.find(options['questionnaire_id'])
    response_data = collect_data(members, questionnaire)
    build_chart(org, questionnaire, response_data)
  end

  private

  def build_chart(org, questionnaire, response_data)
    questions = []
    questionnaire.questions.each do |question|
      questions.push(question) unless response_data.keys.select {|q| q == question.id}.empty?
    end
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Metric')
    response_data[response_data.keys[0]].keys.sort.each do |month|
      data_table.new_column('number', month)
    end
    rows = []
    questions.each do |q|
      row = [q.text]
      response_data[q.id].keys.each do |month|
        row.push(response_data[q.id][month]['average'])
      end
      rows.push(row)
    end
    data_table.add_rows(rows)
    option = { width: 1200, height: 600, title: 'Qualitative Metrics for ' + org.name }
    GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
  end

  def collect_data(members, questionnaire)
    responses = {}
    questionnaire.responses.each do |response|
      next unless int?(response.value)
      next if members.select { |m| m.id == response.team_member_id }.empty?

      responses[response.question.id] = {} if responses[response.question.id].nil?
      responses[response.question.id][response.period_start] = { 'values' => [] } if responses[response.question.id][response.period_start].nil?
      responses[response.question.id][response.period_start]['values'].push(response.value.to_i)
    end
    responses.keys.each do |q|
      responses[q].keys.each do |p|
        responses[q][p]['average'] = responses[q][p]['values'].sum(0.0) / responses[q][p]['values'].count
      end
    end
    responses
  end
end
