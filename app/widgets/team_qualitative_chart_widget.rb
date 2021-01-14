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
      questions.push(question) unless response_data[response_data.keys[0]].keys.select {|q| q == question.id}.empty?
    end
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Month')
    questions.each do |q|
      data_table.new_column('number', q.text)
    end
    rows = []
    response_data.keys.sort.each do |month|
      row = [month.to_s]
      questions.each do |q|
        row.push(response_data[month][q.id]['avaerage'])
      end
      rows.push(row)
    end
    data_table.add_rows(rows)
    option = {width: 600, height: 400, title: 'Qualitative Metrics for ' + org.name}
    GoogleVisualr::Interactive::BarChart.new(data_table, option)
  end

  def collect_data(members, questionnaire)
    responses = {}
    questionnaire.responses.each do |response|
      next unless int?(response.value)
      next if members.select { |m| m.id == response.team_member_id }.empty?

      responses[response.period_start] = {} if responses[response.period_start].nil?
      responses[response.period_start][response.question.id] = { 'values' => [] } if responses[response.period_start][response.question.id].nil?
      responses[response.period_start][response.question.id]['values'].push(response.value.to_i)
    end
    responses.keys.each do |p|
      responses[p].keys.each do |q|
        responses[p][q]['average'] = responses[p][q]['values'].sum(0.0) / responses[p][q]['values'].count
      end
    end
    responses
  end

  def int?(str)
    str.to_i.to_s == str
  end

end
