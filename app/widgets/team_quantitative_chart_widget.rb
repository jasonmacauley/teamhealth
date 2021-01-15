class TeamQuantitativeChartWidget < BaseWidget
  NAME = 'Team Quantitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    results = collect_metrics(options, org)
    data_table = quantitative_data_table(results)

    build_chart(org, data_table)
  end

  private

  def build_chart(org, data_table)
    option = { width: 1200, height: 600, title: 'Quantitative Metrics for ' + org.name }
    GoogleVisualr::Interactive::AreaChart.new(data_table, option)
  end
end
