class BaseWidget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Widget'.freeze
  CHART_TYPES = { 'Bar' => GoogleVisualr::Interactive::BarChart,
                  'Area' => GoogleVisualr::Interactive::AreaChart,
                  'Line' => GoogleVisualr::Interactive::LineChart,
                  'Column' => GoogleVisualr::Interactive::ColumnChart,
                  'Combo' => GoogleVisualr::Interactive::ComboChart }.freeze
  SERIES_TYPES = ['line', 'bar', 'column', 'area'].freeze
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
    return data_table if response_data.empty?
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
    member_ids = []
    members.map { |member| member_ids.push(member.id) }
    filter = question_filter(questionnaire)
    res = questionnaire.responses.where('responses.team_member_id IN (?)', member_ids).group(:question_id, :period_start).average(:value)
    res.each do |r, value|
      next if value.nil? || filter.include?(r[0])

      responses[r[0]] = {} if responses[r[0]].nil?
      responses[r[0]][r[1]] = { 'average' => value }
    end
    responses
  end

  def quantitative_data_table(results)
    data_table = GoogleVisualr::DataTable.new
    return data_table if results.empty?
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
    collect_metrics_by_org(options['metric_type_ids'], org)
  end

  def int?(str)
    str.to_i.to_s == str
  end

  def aggregate_metric(metric, month, results)
    results[month][metric]['type'].aggregate(results[month][metric]['values'])
  end

  protected

  def error_occured(exception)
    render json: { error: exception.message }.to_json, status: 500
    return
  end

  private

  def question_filter(questionnaire)
    q_filter = []
    resps = questionnaire.responses.group(:question_id, :value).distinct(:value).pluck(:question_id, :value)
    resps.each do |q, v|
      q_filter |= [q] unless int? v
    end
    q_filter
  end

  def collect_metrics_by_org(metric_type_ids, org)
    types = []
    metric_type_ids.map { |id| types.push(MetricType.find(id)) if int? id }
    results = org.org_metrics
    res = {}
    results.each do |metrics|
      metrics.each do |metric, value|
        puts 'METRIC ' + metric.to_s
        metric_type = MetricType.find(metric[0])
        next if metric_type.nil?
        month = metric[1]
        res[month] = {} if res[month].nil?
        res[month][metric_type.name] = { 'value' => value, 'type' => metric_type } if res[month][metric_type.name].nil?
        metric_type.target_types.each do |target_type|
          target = target_type.generate(org,
                                        metric_type,
                                        month,
                                        metric[2])

          res[month][target.name] = { 'values' => [], 'type' => target_type } if res[month][target.name].nil?
          res[month][target.name]['values'].push(target.value)
        end
        res.each do |month, target|
          target.each do |metric, value|
            next if value['values'].nil?

            puts 'TARGET ' + value.to_s
            value['value'] = value['type'].aggregate(value['values'])
          end
        end
      end
    end
    res
  end
end
