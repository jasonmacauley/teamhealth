class BaseWidget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Widget'.freeze
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

  def int?(str)
    str.to_i.to_s == str
  end
end
