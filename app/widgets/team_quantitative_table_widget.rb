class TeamQuantitativeTableWidget < BaseWidget
  NAME = 'Team Quantitative Table'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def widget_type
    @widget_type
  end

  def generate(options)
    org = Organization.find(options['organization_id'][0])
    collect_metrics(options, org)
  end
end
