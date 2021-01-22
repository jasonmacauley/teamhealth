class BaseWidget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Widget'.freeze
  CHART_TYPES = { 'Bar' => GoogleVisualr::Interactive::BarChart,
                  'Area' => GoogleVisualr::Interactive::AreaChart,
                  'Line' => GoogleVisualr::Interactive::LineChart,
                  'Column' => GoogleVisualr::Interactive::ColumnChart,
                  'Combo' => GoogleVisualr::Interactive::ComboChart }.freeze
  attr_reader :widget_type

  def initialize()
    @widget_type = nil
  end

  def get_widget(name)
    self.class.descendants.each do |type|
      return type.new if name == type::NAME
    end
  end

  def all_widgets
    widgets = []
    self.class.descendants.each do |type|
      widgets.push(type.new)
    end
    widgets
  end

  def generate(options)
    raise(NotImplementedError)
  end

  def name
    self.class::NAME
  end

  def questionnaire_data_table(questionnaire, response_data)
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
    data_table
  end

  def collect_questionnaire_data(members, questionnaire)
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

  def quantitative_data_table(results)
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'month')
    results[results.keys[0]].keys.sort.each do |metric|
      data_table.new_column('number', metric)
    end
    rows = []
    results.keys.sort.each do |month|
      row = [month]
      results[month].keys.sort.each do |metric|
        stat = aggregate_metric(metric, month, results)
        row.push(stat)
      end
      rows.push(row)
    end
    data_table.add_rows(rows)
    data_table
  end

  def collect_metrics(options, org)
    results = {}
    options['metric_type_ids'].each do |metric_type_id|
      next unless int?(metric_type_id)

      collect_metrics_by_org(metric_type_id, org, results)
    end
    results
  end

  def int?(str)
    str.to_i.to_s == str
  end

  protected

  def error_occured(exception)
    render json: { error: exception.message }.to_json, status: 500
    return
  end

  private

  def aggregate_metric(metric, month, results)
    method = MetricType.find_by_name(metric).aggregation_method
    return results[month][metric]['values'].sum(0.0) / results[month][metric]['values'].count if method =~ /average/i

    results[month][metric]['values'].sum(0.0)
  end

  def collect_metrics_by_org(metric_type_id, org, results)
    org.organizations.each do |o|
      results = collect_metrics_by_org(metric_type_id, o, results)
    end
    metric_type = MetricType.find(metric_type_id)
    Metric.where(organization_id: org.id, metric_type_id: metric_type_id).each do |metric|
      results[metric.period_start] = {} if results[metric.period_start].nil?
      results[metric.period_start][metric_type.name] = { 'values' => [] } if results[metric.period_start][metric_type.name].nil?
      results[metric.period_start][metric_type.name]['values'].push(metric.value)
    end
    results
  end
end
