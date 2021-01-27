class TeamQuantitativeChartWidget < BaseWidget
  NAME = 'Team Quantitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    results = collect_metrics(options, org)
    data_table = quantitative_data_table(results)
    puts 'OPTIONS ' + options.to_s
    build_chart(org, data_table, options)
  end

  private

  def build_chart(org, data_table, options)
    option = { width: 1200,
               height: 600,
               title: 'Quantitative Metrics for ' + org.name,
               legend: 'top' }
    if chart_type =~ /combo/i
      widget = options['widget']
      metrics = widget.get_configs_by_type_name('metrics')

      columns = data_table.cols
      puts 'COLUMNS ' + columns.to_s
    end
    CHART_TYPES[options['chart_type'][0]].new(data_table, option)
  end
end
