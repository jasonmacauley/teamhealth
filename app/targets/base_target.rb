class BaseTarget
  extend ActiveSupport::DescendantsTracker
  NAME = 'Base Target'.freeze

  attr_reader :target_type

  def initialize
    @target_type = TargetType.find_by_name(self.class::NAME)
    load_targets
  end

  def generate(organization, period_start, period_end)
    raise(NotImplementedError)
  end
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
