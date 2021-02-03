class BaseTarget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Target'.freeze
  AGGREGATION_METHOD = ''.freeze

  attr_reader :target_type

  def initialize
    @target_type = TargetType.find_by_name(self.class::NAME)
    load_targets
  end

  def generate(organization, metric_type, period_start, period_end)
    raise(NotImplementedError)
  end

  def aggregate(values)
    raise(NotImplementedError)
  end

  def aggregate_by_sum(values)
    return 0 if values.empty?
    values.sum
  end

  def aggregate_by_average(values)
    return 0 if values.empty?
    (values.sum(0.0) / values.count).round(1)
  end

  private

  def load_targets
    Dir.chdir("#{Rails.root}/app/targets/")
    Dir.glob('*.rb').each do |file|
      class_name = file.split('.')[0]
      require class_name
    end
    self.class.descendants.map { |c| c.new }
  end

  def target_name(metric_type)
    metric_type.name + ' Target'
  end
end
