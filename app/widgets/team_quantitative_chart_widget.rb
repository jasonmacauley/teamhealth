class TeamQuantitativeChartWidget < BaseWidget
  NAME = 'Team Quantitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    results = collect_metrics(options, org)
    data_table = quantitative_data_table(results)
    build_chart(org, data_table, options)
  end

  private

  def build_chart(org, data_table, options)
    option = { width: 1200,
               height: 600,
               title: 'Quantitative Metrics for ' + org.name,
               legend: 'top' }
    if options['chart_type'][0] =~ /combo/i && !options['series_type'].nil?
      combo_chart_options(data_table, option, options)
    end
    CHART_TYPES[options['chart_type'][0]].new(data_table, option)
  end

  private

  def combo_chart_options(data_table, option, options)
    option[:seriesType] = 'bars'
    option[:series] = {}
    index = -1
    columns = data_table.cols.dup
    columns.each do |column|
      type = get_series_type(column[:label], options)
      if type.nil?
        index += 1
        next
      end
      if type =~ /hide/i
        data_table.cols.delete_at(index + 1)
        data_table.rows.map { |row| row.delete_at(index + 1) }
        next
      end
      option[:series][index] = { :type => type }
      index += 1
    end
  end

  def get_series_type(label, options)
    return nil if options['series_type'].nil?

    json = JSON.parse options['series_type'][0]
    json.each do |metric, conf|
      return conf[label] unless conf[label].nil?
    end
    return nil
  end
end
