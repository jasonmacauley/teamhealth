class TeamQualitativeChartWidget < BaseWidget
  NAME = 'Team Qualitative Chart'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end
end
