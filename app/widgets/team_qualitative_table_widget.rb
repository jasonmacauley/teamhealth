class TeamQualitativeTableWidget < BaseWidget
  NAME = 'Team Qualitative Table'.freeze

  def initialize
    @widget_type = WidgetType.find_by_name(self.class::NAME)
  end

  def widget_type
    @widget_type
  end
end
